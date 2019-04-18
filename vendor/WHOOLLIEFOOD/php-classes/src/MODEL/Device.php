<?php

namespace WHOOLLIEFOOD\MODEL;

use \WHOOLLIEFOOD\DB\Sql;

class Device {

    const SESSION = "Device";

    private $idDevice;
    private $idCompany;
	private $desName;
	private $desLogin;
	private $desPassword;
	private $isActive;

    public function __construct(){
		$this->idCompany = $_SESSION['User']['idCompany'];
	}

	public function getIdDevice() {
		return $this->idDevice;
	}

	public function setIdDevice($idDevice) {
		$this->idDevice = $idDevice;
	}

	public function getIdCompany() {
		return $this->idCompany;
	}

	public function setIdCompany($idCompany) {
		$this->idCompany = $idCompany;
	}

	public function getDesName() {
		return $this->desName;
	}

	public function setDesName($desName) {
		$this->desName = $desName;
	}

	public function getDesLogin() {
		return $this->desLogin;
	}

	public function setDesLogin($desLogin) {
		$this->desLogin = $desLogin;
	}

	public function getDesPassword() {
		return $this->desPassword;
	}

	public function setDesPassword($desPassword) {
		$this->desPassword = sha1($desPassword);
	}

	public function getIsActive() {
		return $this->isActive;
	}

	public function setIsActive($isActive) {
		$this->isActive = $isActive;
    }

    public static function login($login, $password) {

		$sql = new Sql();

		$results = $sql->select("SELECT * FROM tbDevices 
								 WHERE 
								 desLogin = :LOGIN AND 
								 isDeleted = :ISDELETED AND 
								 isActive = :ISACTIVE", array(
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

			$_SESSION[Device::SESSION] = $data;

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

    public static function verifyLogin(){

		if(!isset($_SESSION[Device::SESSION]) || !$_SESSION[Device::SESSION] || !(int)$_SESSION[Device::SESSION]["idDevice"] > 0){
			
			return [
                'login' => false,
                'message' => 'Não logado!',
            ];	

		} else {

			return [
                'login' => true
            ];	

		}

	}
    
    public function createDevice() {

        $sql = new Sql();

		$idDevice = $sql->query("INSERT INTO tbDevices(idCompany, desName, desLogin, desPassword) 
						    VALUES (:IDCOMPANY, :DESNAME, :DESLOGIN, :DESPASSWORD)", [
                            ":IDCOMPANY"=>$this->getIdCompany(),
                            ":DESNAME"=>$this->getDesName(),
                            ":DESLOGIN"=>$this->getDesLogin(),
                            ":DESPASSWORD"=>$this->getDesPassword()
        ]);

        $this->setIdDevice($idDevice);

        if($this->getIdDevice() > 0) {
            echo json_encode([
                'error' => false
            ]);
        } else {
            echo json_encode([
                'error' => true,
                'message' => 'Erro ao criar novo dispositivo!'
            ]);
        }
		
    }

    public function editDevice() {

        $sql = new Sql();

        if ($this->getDesPassword() != "") {
            $sql->query("UPDATE tbDevices
                        SET 
                        desPassword = :DESPASSWORD
                        WHERE
                        idDevice = :IDDEVICE", [
                                ":IDDEVICE"=>$this->getIdDevice(),
                                ":DESPASSWORD"=>$this->getDesPassword()
            ]);
        }

        $sql->query("UPDATE tbDevices
                    SET 
                    desName = :DESNAME, 
                    desLogin = :DESLOGIN
                    WHERE
                    idDevice = :IDDEVICE", [
                            ":IDDEVICE"=>$this->getIdDevice(),
                            ":DESNAME"=>$this->getDesName(),
                            ":DESLOGIN"=>$this->getDesLogin()
        ]);
		
        echo json_encode([
            'error' => false
        ]);
		

    }
    
    public function listAllDevices() {

        $sql = new Sql();

        return json_encode($sql->select("SELECT *
                             FROM tbDevices
                             ORDER BY desName"));

    }

    public function listDeviceById() {

        $sql = new Sql();

        return json_encode($sql->select("SELECT *
                                        FROM tbDevices
                                        WHERE 
                                        idDevice = :IDDEVICE
                                        ORDER BY desName", [
                                            ":IDDEVICE"=>$this->getIdDevice()
                                        ]));

    }


}

?>