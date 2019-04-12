<?php

namespace WHOOLLIEFOOD\MODEL;

use \WHOOLLIEFOOD\DB\Sql;

class ProductCategory{

    private $desName;
    private $idCompany;
    private $isActive;

    public function __construct(){

		$this->idCompany = $_SESSION['User']['idCompany'];

	}

    public function setDesName($desName){
        $this->desName = $desName;
    }

    public function setIsActive($isActive){
        $this->isActive = $isActive;
    }

    public function getDesName(){
        return $this->desName;
    }

    public function getIdCompany(){
		return $this->idCompany;
    }
    
    public function getIsActive(){
        return $this->isActive;
    }

    public function createProductCategory(){

        $sql = new Sql();

        if($this->getDesName() != ""){

            $sql->query("INSERT INTO tbProductsCategories(idCompany, desName, isActive) 
			VALUES (:IDCOMPANY, :DESNAME, :ISACTIVE)", [
				":IDCOMPANY"=>$this->getIdCompany(),
                ":DESNAME"=>$this->getDesName(),
                ":ISACTIVE"=>$this->getIsActive()
            ]);

        }
       
    }

    public function updateProductCategory($idProductCategory){

        $sql = new Sql();

        if($this->getDesName() != ""){

            $sql->query("UPDATE tbProductsCategories SET desName = :DESNAME, isActive = :ISACTIVE WHERE idProductCategory = :IDPRODUCTCATEGORY", [
                ":DESNAME"=>$this->getDesName(),
                ":ISACTIVE"=>$this->getIsActive(),
                ":IDPRODUCTCATEGORY"=> $idProductCategory
            
            ]);

        }
       
    }

    public function deleteProductCategory($idProductCategory){

        $sql = new Sql();

        $sql->query("UPDATE tbProductsCategories SET isDeleted = :ISDELETED WHERE idProductCategory = :IDPRODUCTCATEGORY", [
            ":ISDELETED"=> 1,
            ":IDPRODUCTCATEGORY"=> $idProductCategory
        ]);
       
    }

    public function returnProductCategoryById($idProductCategory){

        $sql = new Sql();

        return json_encode($sql->select("SELECT * FROM tbProductsCategories WHERE idProductCategory = :IDPRODUCTCATEGORY",[
            ":IDPRODUCTCATEGORY" => $idProductCategory,
        ]));
       
    }

    public function listAll(){

        $sql = new Sql();

        return json_encode($sql->select("SELECT * FROM tbProductsCategories WHERE idCompany = :IDCOMPANY AND isDeleted = :ISDELETED", [
            ':IDCOMPANY' => $this->getIdCompany(),
            ':ISDELETED' => 0
        ]));

    }



}

?>