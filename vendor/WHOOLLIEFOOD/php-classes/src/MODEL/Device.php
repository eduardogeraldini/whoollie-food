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
    private $isDeleted;
    private $idBoard;
    
    public function __construct() {
        if (isset($_SESSION[Device::SESSION]))
            $this->idDevice = $_SESSION[Device::SESSION]["idDevice"];

        if (isset($_SESSION[User::SESSION]))
            $this->idCompany = $_SESSION[User::SESSION]["idCompany"];
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
    
    public function getIdBoard() {
		return $this->idBoard;
	}

	public function setIdBoard($idBoard) {
		$this->idBoard = $idBoard;
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

    public function getIsDeleted() {
		return $this->isDeleted;
	}

	public function setIsDeleted($isDeleted) {
		$this->isDeleted = $isDeleted;
    }

    public function login() {

		$sql = new Sql();

		$results = $sql->select("SELECT * 
                                 FROM tbDevices a
                                 INNER JOIN tbCompanies b ON(a.idCompany = b.idCompany) 
								 WHERE 
								 a.desLogin = :LOGIN AND 
								 a.isDeleted = :ISDELETED AND 
								 a.isActive = :ISACTIVE", [
			":LOGIN"=>$this->getDesLogin(),
			":ISDELETED"=>$this->getIsDeleted(),
			":ISACTIVE"=>$this->getIsActive()
        ]);

		if(count($results) === 0){

            return json_encode([
                'login' => false,
                'message' => 'Credenciais incorretas (login)!',
            ]);
			
		}

		$data = $results[0];

		if($this->getDesPassword() == $data["desPassword"]){

            $_SESSION[Device::SESSION] = $data;
            
            $_SESSION[User::SESSION] = NULL;

			return json_encode([
                'login' => true,
                'message' => 'Logado com sucesso!',
            ]);

		} else {

			return json_encode([
                'login' => false,
                'message' => 'Credenciais incorretas (password)!',
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

		$idDevice = $sql->query("INSERT INTO tbDevices(idCompany, desName, desLogin, desPassword, isActive, idBoard) 
						    VALUES (:IDCOMPANY, :DESNAME, :DESLOGIN, :DESPASSWORD, :ISACTIVE, :IDBOARD)", [
                            ":IDCOMPANY"=>$this->getIdCompany(),
                            ":DESNAME"=>$this->getDesName(),
                            ":DESLOGIN"=>$this->getDesLogin(),
                            ":DESPASSWORD"=>$this->getDesPassword(),
                            ":ISACTIVE"=>$this->getIsActive(),
                            ":IDBOARD"=>$this->getIdBoard()
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

        if ($this->getDesPassword() != sha1("")) {
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
                    desLogin = :DESLOGIN,
                    isActive = :ISACTIVE,
                    idBoard = :IDBOARD
                    WHERE
                    idDevice = :IDDEVICE", [
                            ":IDDEVICE"=>$this->getIdDevice(),
                            ":DESNAME"=>$this->getDesName(),
                            ":DESLOGIN"=>$this->getDesLogin(),
                            ":ISACTIVE"=>$this->getIsActive(),
                            ":IDBOARD"=>$this->getIdBoard()
        ]);
		
        return json_encode([
            'error' => false
        ]);
		

    }

    public function deleteDevice() {

        $sql = new Sql();

        $sql->query("UPDATE tbDevices
                    SET 
                    isDeleted = :ISDELETED
                    WHERE
                    idDevice = :IDDEVICE", [
                            ":IDDEVICE"=>$this->getIdDevice(),
                            ":ISDELETED"=>$this->getIsDeleted()
        ]);
		
        return json_encode([
            'error' => false
        ]);
		

    }
    
    public function listAllDevices() {

        $sql = new Sql();

        return json_encode($sql->select("SELECT *
                            FROM tbDevices a
                            INNER JOIN tbBoards b
                            ON (a.idBoard = b.idBoard) 
                            WHERE a.isDeleted = :ISDELETED
                            ORDER BY a.desName", [
                                 ":ISDELETED"=> $this->getIsDeleted()
                             ]));

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