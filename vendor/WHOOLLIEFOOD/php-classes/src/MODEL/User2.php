<?php 

namespace WHOOLLIEFOOD\MODEL;

use \WHOOLLIEFOOD\DB\Sql;
use \WHOOLLIEFOOD\MODEL\JWTProvider;

class User{

	public static function login($login, $password){

		$sql = new Sql();

		$results = $sql->select("SELECT * FROM tbEmployees a INNER JOIN tbUsers b ON (a.idLogin = b.idUser) WHERE b.desLogin = :LOGIN", array(
			":LOGIN"=>$login
        ));

		if(count($results) === 0){
  
            return json_encode([
                'login' => 'false',
                'message' => 'Credenciais incorretas!',
            ]);
			
		}

        $data = $results[0];

		if(sha1($password) == $data["desPassword"]){
 
            $jwt = JWTProvider::encode([
                'expiration_sec' => 3600,
                'iss' => 'localhost',
                'userdata' => $data
            ]);

            return json_encode([
                'login' => 'true',
                'access_token' => $jwt
            ]);

		} else {
            
            return json_encode([
                'login' => 'false',
                'message' => 'Credenciais incorretas!',
            ]);

		}

	}

}

?>