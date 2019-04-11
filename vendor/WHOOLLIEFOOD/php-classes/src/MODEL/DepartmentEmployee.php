<?php

namespace WHOOLLIEFOOD\MODEL;

use \WHOOLLIEFOOD\DB\Sql;

class DepartmentEmployee{

    private $desName;
    private $idCompany;

    public function __construct(){

		$this->idCompany = $_SESSION['User']['idCompany'];

	}

    public function setDesName($desName){
        $this->desName = $desName;
    }

    public function getDesName(){
        return $this->desName;
    }

    public function getIdCompany(){
		return $this->idCompany;
	}

    public function createDepartmentEmployee(){

        $sql = new Sql();

        if($this->getDesName() != ""){

            $sql->query("INSERT INTO tbDepartments (idCompany, desName) 
			VALUES (:IDCOMPANY, :DESNAME)", [
				":IDCOMPANY"=>$this->getIdCompany(),
				":DESNAME"=>$this->getDesName(),
            ]);

        }
       
    }

    public function updateDepartmentEmployee($idDepartment){

        $sql = new Sql();

        if($this->getDesName() != ""){

            $sql->query("UPDATE tbDepartments SET desName = :DESNAME WHERE idDepartment = :IDDEPARTMENT", [
                ":DESNAME"=>$this->getDesName(),
                ":IDDEPARTMENT"=> $idDepartment
            ]);

        }
       
    }

    public function deleteDepartmentEmployee($idDepartment){

        $sql = new Sql();

            $sql->query("UPDATE tbDepartments SET isDeleted = :ISDELETED WHERE idDepartment = :IDDEPARTMENT", [
                ":ISDELETED"=> 1,
                ":IDDEPARTMENT"=> $idDepartment
            ]);
       
    }

    public function returnDepartmentById($idDepartment){

        $sql = new Sql();

        return json_encode($sql->select("SELECT * FROM tbDepartments WHERE idDepartment = :IDDEPARTMENT",[
            ":IDDEPARTMENT" => $idDepartment,
        ]));
       
    }

    public function listAll(){

        $sql = new Sql();

        return json_encode($sql->select("SELECT * FROM tbDepartments WHERE idCompany = :IDCOMPANY AND isDeleted = :ISDELETED",[
            ":IDCOMPANY" => $this->getIdCompany(),
            ":ISDELETED" => 0
        ]));

    }



}

?>