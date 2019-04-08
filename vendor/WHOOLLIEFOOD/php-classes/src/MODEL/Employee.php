<?php

namespace WHOOLLIEFOOD\MODEL;

use \WHOOLLIEFOOD\DB\Sql;

class Employee{

    private $desName;
    private $desCPF;
    private $dtBirth;
    private $isActive;
    private $isDeleted;
    private $idDepartment;
    private $idUser;
    private $idCompany;

    public function __construct(){

        $this->idCompany = $_SESSION['User']['idCompany'];

	}

    public function setDesName($desName){
        $this->desName = $desName;
    }

    public function setDesCPF($desCPF){
        $this->desCPF = $desCPF;
    }

    public function setDtBirth($dtBirth){
        $this->dtBirth = $dtBirth;
    }

    public function setIdDepartment($idDepartment){
        $this->idDepartment = $idDepartment;
    }

    public function setIdUser($idUser){
        $this->idUser = $idUser;
    }

    public function setIsActive($isActive){
        $this->isActive = $isActive;
    }

    public function setIsDeleted($isDeleted){
        $this->isDeleted = $isDeleted;
    }

    public function getDesName(){
        return $this->desName;
    }

    public function getDesCPF(){
        return $this->desCPF;
    }

    public function getDtBirth(){
        return $this->dtBirth;
    }

    public function getIdDepartment(){
        return $this->idDepartment;
    }

    public function getIdUser(){
        return $this->idUser;
    }

    public function getIsActive(){
        return $this->isActive;
    }

    public function getIsDeleted(){
        return $this->isDeleted;
    }

    public function getIdCompany(){
		return $this->idCompany;
    }

    public function createEmployee(){

        $sql = new Sql();

        if($this->getDesName() != "" && $this->getDesCPF() != "" && $this->getDtBirth() != ""){

            $sql->query("INSERT INTO tbEmployees(idCompany, idDepartment, idUser, desName, desCPF, dtBirth, isActive) 
			VALUES (:IDCOMPANY, :IDDEPARTMENT, :IDUSER, :DESNAME, :DESCPF, :DTBIRTH, :ISACTIVE)", [
				":IDCOMPANY"=>$this->getIdCompany(),
                ":IDDEPARTMENT"=>$this->getIdDepartment(),
                ":IDUSER"=>$this->getIdUser(),
                ":DESNAME"=>$this->getDesName(),
                ":DESCPF"=>$this->getDesCPF(),
                ":DTBIRTH"=>$this->getDtBirth(),
                ":ISACTIVE"=>$this->getIsActive()
            ]);

            
            $sql->query("INSERT INTO tbPrivileges(idEmployee) 
			VALUES (:IDEMPLOYEE)", [
				":IDEMPLOYEE"=>$this->returnLastEmployee(),
            ]);

        }
       
    }

    public function returnLastEmployee(){

		$sql = new Sql();

		return $sql->select("SELECT MAX(idEmployees) FROM tbEmployees WHERE idCompany = :IDCOMPANY",[
			":IDCOMPANY" => $_SESSION['User']['idCompany']
		])[0]['MAX(idEmployees)'];

	}

    public function securePrivileges($idEmployee, $column, $value){

        $sql = new Sql();

        return $sql->query("UPDATE tbPrivileges 
            SET $column = :VAL
            WHERE idEmployee = :IDEMPLOYEE", [
            ":VAL" => $value,
            ":IDEMPLOYEE" => $idEmployee
         ]);

    }


    public function listAll(){

        $sql = new Sql();

        return json_encode($sql->select("SELECT a.idEmployees, b.idDepartment, a.desName AS 'desNameF', b.desName AS 'desNameD', c.viewProducts, c.viewOrders, c.viewEmployees, c.viewReports, c.viewConfigs FROM tbEmployees a 
            INNER JOIN tbDepartments b ON (a.idDepartment = b.idDepartment) 
            INNER JOIN tbPrivileges c ON (a.idEmployees = c.idEmployee) WHERE a.idCompany = :IDCOMPANY",[
                ":IDCOMPANY"=>$this->getIdCompany()
            ]));

    }

    public function listCurrentEmployee() {
        
        $sql = new Sql();

		return json_encode($sql->select("SELECT e.* FROM tbEmployees e
                                         INNER JOIN tbUsers u ON (e.idUser = u.idUser)
                                         WHERE 
                                         e.idEmployee = :IDCOMPANY ", [
            ":IDCOMPANY" => $this->getIdCompany()
        ]));

    }

}

?>