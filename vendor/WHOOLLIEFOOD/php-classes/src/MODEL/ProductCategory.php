<?php

namespace WHOOLLIEFOOD\MODEL;

use \WHOOLLIEFOOD\DB\Sql;

class ProductCategory{

    private $idProductCategory;
    private $desName;
    private $idCompany;
    private $isActive;
    private $desImagePath;

    public function __construct(){
		if (isset($_SESSION['User']['idCompany']))
			$this->idCompany = $_SESSION['User']['idCompany'];
		else
			$this->idCompany = $_SESSION['Device']['idCompany'];
	}

    public function setIdProductCategory($idProductCategory) {
        $this->idProductCategory = $idProductCategory;
    }

    public function setDesName($desName){
        $this->desName = $desName;
    }

    public function setIsActive($isActive){
        $this->isActive = $isActive;
    }

    public function setDesImagePath($files, $desOldImagePath = "") {

		if ($desOldImagePath == "" && $files["desImagePath"]["name"] == "") {

			$this->desImagePath = "/res/admin/img/sem_foto.png";
			
			echo json_encode([
				'error' => false
			]);
				
			return;

		} elseif ($files["desImagePath"]["name"] != "") {
		
			if ($desOldImagePath != "/res/admin/img/sem_foto.png")
				deleteFile($desOldImagePath);
		
		} elseif ($desOldImagePath != "" && $files["desImagePath"]["name"] == "") {

			$this->desImagePath = $desOldImagePath;

			echo json_encode([
				'error' => false
			]);
				
			return;

		} 

		$target_dir = "res/uploads/productsCategories/";
		$target_file = $target_dir . time() . "_" . basename($files["desImagePath"]["name"]);
		$imageFileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));
		
		if(getimagesize($files["desImagePath"]["tmp_name"]) === false) {
			echo json_encode([
				'error' => true,
				"message" => "Arquivo não é uma imagem válida!"
			]);
			exit;
		}

		if (file_exists($target_file)) {
			echo json_encode([
				'error' => true,
				"message" => "Imagem já existente em nosso banco de dados!"
			]);
			exit;
		}

		if ($files["desImagePath"]["size"] > 5 * 1024 * 1024) {
			echo json_encode([
				'error' => true,
				"message" => "Imagem muito grande. Insira uma imagem de até 5MB!"
			]);
			exit;
		}

		if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg" && $imageFileType != "gif" ) {
			echo json_encode([
				'error' => true,
				"message" => "Tipo de imagem incorreto, somente JPG, JPEG, PNG e GIF!"
			]);
			exit;
		}

		if (move_uploaded_file($files["desImagePath"]["tmp_name"], $target_file)) {
			$this->desImagePath = "/".$target_file;
			echo json_encode([
				'error' => false
			]);
			return;
		} else {
			echo json_encode([
				'error' => true,
				"message" => "Erro ao transferir imagem!"
			]);
			exit;
		}

	}

    public function getIdProductCategory() {
        return $this->idProductCategory;
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

    public function getDesImagePath() {
		return $this->desImagePath;
    }
    

    public function createProductCategory(){

        $sql = new Sql();

        if($this->getDesName() != ""){

            $sql->query("INSERT INTO tbProductsCategories(idCompany, desName, desImagePath, isActive) 
			VALUES (:IDCOMPANY, :DESNAME, :DESIMAGEPATH, :ISACTIVE)", [
				":IDCOMPANY"=>$this->getIdCompany(),
                ":DESNAME"=>$this->getDesName(),
                ":DESIMAGEPATH"=>$this->getDesImagePath(),
                ":ISACTIVE"=>$this->getIsActive()
            ]);

        }
       
    }

    public function updateProductCategory(){

        $sql = new Sql();

        if($this->getDesName() != ""){
            
            $sql->query("UPDATE tbProductsCategories SET 
                            desName = :DESNAME, 
                            isActive = :ISACTIVE,
                            desImagePath = :DESIMAGEPATH
                        WHERE 
                            idProductCategory = :IDPRODUCTCATEGORY", [
                ":DESNAME"=>$this->getDesName(),
                ":ISACTIVE"=>$this->getIsActive(),
                ":IDPRODUCTCATEGORY"=>$this->getIdProductCategory(),
                ":DESIMAGEPATH"=>$this->getDesImagePath()            
            ]);

        }
       
    }

    public function hasRelations($idProductCategory) {

		$sql = new Sql();

        $res = $sql->select("SELECT COUNT(idProduct) AS 'TOTAL'
                             FROM tbProducts
                             WHERE 
                             idProductCategory = :IDPRODUCTCATEGORY;", [
                ":IDPRODUCTCATEGORY"=>$idProductCategory                       
		]);
		
		if((int)$res[0]["TOTAL"] > 0) {
			return true;
		} else {
			return false;
		}

	}

    public function deleteProductCategory($idProductCategory){

        $sql = new Sql();

        if ($this->hasRelations($idProductCategory)) {
			return json_encode(["error" => true, "message" => "A categoria possui produtos relacionados. Não será possível excluí-la!"]);
		}

        $sql->query("UPDATE tbProductsCategories SET isDeleted = :ISDELETED WHERE idProductCategory = :IDPRODUCTCATEGORY", [
            ":ISDELETED"=> 1,
            ":IDPRODUCTCATEGORY"=> $idProductCategory
        ]);

        return json_encode(["error" => false]);
       
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