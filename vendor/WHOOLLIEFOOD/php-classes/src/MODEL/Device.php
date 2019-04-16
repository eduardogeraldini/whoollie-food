<?php

namespace WHOOLLIEFOOD\MODEL;

use \WHOOLLIEFOOD\DB\Sql;

class Device {

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
    
    public function listAllDevices() {

        $sql = new Sql();

        return json_encode($sql->select("SELECT *
                             FROM tbDevices
                             ORDER BY desName"));

    }


}

?>