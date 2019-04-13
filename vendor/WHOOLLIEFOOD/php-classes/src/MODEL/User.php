<?php 

namespace WHOOLLIEFOOD\MODEL;

use \WHOOLLIEFOOD\DB\Sql;

class User{

	const SESSION = "User";

	public static function login($login, $password){

		$sql = new Sql();

		$results = $sql->select("SELECT * FROM tbUsers a INNER JOIN tbEmployees b ON(a.idUser = b.idUser) WHERE a.desLogin = :LOGIN AND b.isDeleted = :ISDELETED AND b.isActive = :ISACTIVE", array(
			":LOGIN"=>$login,
			":ISDELETED" => 0,
			":ISACTIVE" =>  1
		));

		if(count($results) === 0){

            return json_encode([
                'login' => false,
                'message' => 'Credenciais incorretas!',
            ]);
			
		}

		$data = $results[0];

		if(sha1($password) == $data["desPassword"]){

			$_SESSION[User::SESSION] = $data;

			return json_encode([
                'login' => true,
                'message' => 'Logado com sucesso!',
            ]);

		} else {

			return json_encode([
                'login' => false,
                'message' => 'Credenciais incorretas!',
            ]);

		}

	}

	public static function verifyLogin($isAPI = true, $login = false){

		if(!isset($_SESSION[User::SESSION]) || !$_SESSION[User::SESSION] || !(int)$_SESSION[User::SESSION]["idUser"] > 0){
			
			if ($isAPI) {
				echo json_encode([
					'login' => false,
					'message' => 'Não logado!',
				]);		
				exit;
			} else {
				if (!$login) {
					header("Location: /entrar");
					exit;
				}	
			}
		} else {

			if ($login) {
				header("Location: /inicio");
				exit;
			}	

		}

	}

	public static function logout(){

		$_SESSION[User::SESSION] = NULL;

		echo json_encode([
			'login' => false,
			'message' => 'Você foi deslogado!'
		]);

	}

	public static function createUser($desLogin, $desPassword){
		
		$sql = new Sql();

		if($desLogin != "" && $desPassword != "") {

			return $sql->query("INSERT INTO tbUsers(desLogin, desPassword, idCompany) 
						VALUES (:DESLOGIN, :DESPASSWORD, :IDCOMPANY)", [
				":DESLOGIN"=>$desLogin,
				":DESPASSWORD"=>sha1($desPassword),
				":IDCOMPANY"=> $_SESSION['User']['idCompany']
			]);

		}
		
	}

	public static function returnUserLoginById($idLogin){

		$sql = new Sql();

		if($idLogin != "") {

			return json_encode($sql->select("SELECT idUser, desLogin FROM tbUsers WHERE idUser = :IDLOGIN", array(
				":IDLOGIN"=>$idLogin
			)));

		}

	}

	public static function updatePassword($idUser, $login, $password){

		$sql = new Sql();

		if($idUser != "") {

			return $sql->query("UPDATE tbUsers SET desLogin = :DESLOGIN, desPassword = :DESPASSWORD WHERE idUser = :IDUSER", array(
				":DESLOGIN"=>$login,
				":DESPASSWORD"=>sha1($password),
				":IDUSER"=>$idUser
			));

		}

	}

}

?>