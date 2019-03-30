<?php

namespace WHOOLLIEFOOD\MODEL;

use \WHOOLLIEFOOD\DB\Sql;

class ProductCategory{

    private $desName;

    public function setDesName($desName){
        $this->desName = $desName;
    }

    public function getDesName(){
        return $this->desName;
    }

    public function createProductCategory(){

        $sql = new Sql();

		$sql->query("INSERT INTO tbProductsCategories(desName) 
			VALUES (:DESNAME)", [
				":DESNAME"=>$this->getDesName(),
            ]);
            
    }


    public function listAll(){

        $sql = new Sql();

        return json_encode($sql->select("SELECT * FROM tbProductsCategories"));

    }



}

?>