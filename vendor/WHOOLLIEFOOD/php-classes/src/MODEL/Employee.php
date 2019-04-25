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
    private $idEmployee;

    public function __construct(){

        $this->idCompany = $_SESSION['User']['idCompany'];
        $this->idUser = $_SESSION['User']["idUser"];

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

            $lastId = $sql->query("INSERT INTO tbEmployees(idCompany, idDepartment, idUser, desName, desCPF, dtBirth, isActive) 
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
				":IDEMPLOYEE"=>$lastId
            ]);

        }
       
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

        return json_encode($sql->select("SELECT a.idEmployee, b.idDepartment, a.idUser, a.isActive, a.desName AS 'desNameF', b.desName AS 'desNameD', c.viewProducts, c.viewOrders, viewBoards, viewMonitor, viewDevices, viewIngredients, c.viewEmployees, c.viewReports, c.viewConfigs 
            FROM tbEmployees a 
            INNER JOIN tbDepartments b ON (a.idDepartment = b.idDepartment) 
            INNER JOIN tbPrivileges c ON (a.idEmployee = c.idEmployee) 
            WHERE a.idCompany = :IDCOMPANY AND
            a.isDeleted = 0",[
                ":IDCOMPANY"=>$this->getIdCompany()
            ]));

    }

    public function listEmployeeById($idEmployee){

        $sql = new Sql();

		return json_encode($sql->select("SELECT a.idEmployee, b.idDepartment, a.desName AS 'desNameF', b.desName AS 'desNameD', a.desCPF, a.isActive, a.dtBirth FROM tbEmployees a
            INNER JOIN tbDepartments b ON (a.idDepartment = b.idDepartment)
            WHERE a.idEmployee = :IDEMPLOYEE",[
            ':IDEMPLOYEE' => $idEmployee
        ]));

    }
    
    public function listCurrentEmployee(){

        $sql = new Sql();

		return json_encode($sql->select("SELECT a.desName, a.idEmployee 
            FROM tbEmployees a
            INNER JOIN tbUsers b ON (a.idUser = b.idUser)
            WHERE a.idUser = :IDUSER",[
            ':IDUSER' => $this->getIdUser()
        ]));

    }
    
    public function editEmployee($idEmployee){

        $sql = new Sql();

        if($this->getDesName() != "" && $this->getDesCPF() != "" && $this->getDtBirth() != ""){

            return $sql->query("UPDATE tbEmployees SET desName = :DESNAME, desCPF = :DESCPF, dtBirth = :DTBIRTH, isActive = :ISACTIVE, idDepartment = :IDDEPARTMENT
                WHERE idCompany = :IDCOMPANY AND idEmployee = :IDEMPLOYEE", [
                ":DESNAME"=>$this->getDesName(),
                ":DESCPF"=>$this->getDesCPF(),
                ":DTBIRTH"=>$this->getDtBirth(),
                ":ISACTIVE"=>$this->getIsActive(),
                ":IDDEPARTMENT"=>$this->getIdDepartment(),
                ":IDCOMPANY"=>$this->getIdCompany(),
                ":IDEMPLOYEE"=>$idEmployee                       
            ]);
                
        } 
    
    }  
    
    public function deleteEmployee($idEmployee){

        $sql = new Sql();

        return $sql->query("UPDATE tbEmployees SET isDeleted = :ISDELETED
                WHERE idCompany = :IDCOMPANY AND idEmployee = :IDEMPLOYEE", [
                ":ISDELETED"=>$this->getIsDeleted(),
                ":IDCOMPANY"=>$this->getIdCompany(),
                ":IDEMPLOYEE"=>$idEmployee                       
            ]);
    
    } 

    public static function verifyPrivileges($module) {

        $sql = new Sql();
        $employee = new Employee();
        $idEmployee = json_decode($employee->listCurrentEmployee(), true);
    

        $results = $sql->select("SELECT * FROM tbPrivileges 
            WHERE idEmployee = :IDEMPLOYEE", [
            ":IDEMPLOYEE" => $idEmployee[0]['idEmployee']
         ]);

        $data = $results[0];

        switch ($module) {

            case 'products':
                if($data["viewProducts"] == 0){
                    return false;
                }
                else {
                    return true;
                }  
                
            case 'orders':
                if($data["viewOrders"] == 0){
                    return false;
                } else {
                    return true;
                }   

            case 'boards':
                if($data["viewBoards"] == 0){
                    return false;
                } else {
                    return true;
                }    

            case 'monitor':
                if($data["viewMonitor"] == 0){
                    return false;
                } else {
                    return true;
                }   

            case 'devices':
                if($data["viewDevices"] == 0){
                    return false;
                } else {
                    return true;
                }  

            case 'ingredients':
                if($data["viewIngredients"] == 0){
                    return false;
                } else {
                    return true;
                }    

            case 'employees':
                if($data["viewEmployees"] == 0){
                    return false;
                } else {
                    return true;
                } 

            case 'reports':
                if($data["viewReports"] == 0){
                    return false;
                } else {
                    return true;
                }   

            case 'configs':
                if($data["viewConfigs"] == 0){
                    return false;
                } else {
                    return true;
                }  

            default:
                return false;

        }

    }

}

?>