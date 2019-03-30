<?php 

namespace WHOOLLIEFOOD\MODEL;

use \WHOOLLIEFOOD\DB\Sql;

class User{

	const SESSION = "User";

	public static function login($login, $password){

		$sql = new Sql();

		$results = $sql->select("SELECT * FROM tbUsers WHERE desLogin = :LOGIN", array(
			":LOGIN"=>$login
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

	public static function verifyLogin($isAPI = true){

		if(!isset($_SESSION[User::SESSION]) || !$_SESSION[User::SESSION] || !(int)$_SESSION[User::SESSION]["idUser"] > 0){
			
			if ($isAPI) {
				echo json_encode([
					'login' => 'false',
					'message' => 'Não logado!',
				]);
				exit;
			} else {
				header("Location: /whoollie-food/login");
				exit;
			}
			
		}
	}

	public static function logout(){

		$_SESSION[User::SESSION] = NULL;

	}

}

?>