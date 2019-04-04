<?php

namespace WHOOLLIEFOOD\MODEL;

use \WHOOLLIEFOOD\DB\Sql;

class ProductCategory{

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

    public function createProductCategory(){

        $sql = new Sql();

        if($this->getDesName() != ""){

            $sql->query("INSERT INTO tbProductsCategories(idCompany, desName) 
			VALUES (:IDCOMPANY, :DESNAME)", [
				":IDCOMPANY"=>$this->getIdCompany(),
				":DESNAME"=>$this->getDesName(),
            ]);

        }
       
    }

    public function listAll(){

        $sql = new Sql();

        return json_encode($sql->select("SELECT * FROM tbProductsCategories"));

    }



}

?>