<?php

namespace WHOOLLIEFOOD\MODEL;

use \WHOOLLIEFOOD\DB\Sql;

class Product{

	private $desName;
	private $desNote;
	private $desImagePath;
	private $vlUnity;
	private $isActive;
	private $isDeleted;
	private $idProduct;
	private $idCompany;
	private $idProductCategory;

	public function __construct(){
		if (isset($_SESSION['User']['idCompany']))
			$this->idCompany = $_SESSION['User']['idCompany'];
		else
			$this->idCompany = $_SESSION['Device']['idCompany'];
	}

	public function setDesName($desName){
		$this->desName = $desName;
	}

	public function setDesNote($desNote){
		$this->desNote = $desNote;
	}

	public function setVlUnity($vlUnity){
		$this->vlUnity = $vlUnity;
	}

	public function setIdProductCategory($idProductCategory){
		$this->idProductCategory = $idProductCategory;
	}

	public function setIsActive($isActive) {
		$this->isActive = $isActive;
	}

	public function setIsDeleted($isDeleted) {
		$this->isDeleted = $isDeleted;
	}

	public function setIdProduct($idProduct) {
		$this->idProduct = $idProduct;
	}

	public function setDesImagePath($files, $desOldImagePath = "") {

		if ($desOldImagePath == "" && $files["desImagePath"]["name"] == "") {

			$this->desImagePath = "res/admin/img/sem_foto.png";
			
			echo json_encode([
				'error' => false
			]);
				
			return;

		} elseif ($files["desImagePath"]["name"] != "") {
		
			if ($desOldImagePath != "res/admin/img/sem_foto.png")
				deleteFile($desOldImagePath);
		
		} elseif ($desOldImagePath != "" && $files["desImagePath"]["name"] == "") {

			$this->desImagePath = $desOldImagePath;

			echo json_encode([
				'error' => false
			]);
				
			return;

		} 


		$target_dir = "res/uploads/products/";
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
			$this->desImagePath = $target_file;
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

	public function getDesName(){
		return $this->desName;
	}

	public function getDesNote(){
		return $this->desNote;
	}

	public function getVlUnity(){
		return $this->vlUnity;
	}

	public function getIdProductCategory(){
		return $this->idProductCategory;
	}

	public function getIdCompany(){
		return $this->idCompany;
	}

	public function getIsActive(){
		return $this->isActive;
	}

	public function getIsDeleted(){
		return $this->isDeleted;
	}

	public function getDesImagePath() {
		return $this->desImagePath;
	}

	public function getIdProduct() {
		return $this->idProduct;
	}

	public function listAll(){

		$sql = new Sql();
		
		return json_encode($sql->select("
				SELECT * 
				FROM tbProducts
				WHERE 
				isDeleted = :ISDELETED AND
				idCompany = :IDCOMPANY
				ORDER BY desName ASC", [
					":ISDELETED" => 0,
					":IDCOMPANY" => $this->getIdCompany()
			]));

	}

	public function listFilterProducts($args) {

		$sql = new Sql();

		$query = "SELECT * FROM tbProducts ";
		$array = [];

		if (count($args) > 0) {
			$query .= " WHERE ";
		}

		$i = 0;

		foreach ($args as $key => $value) {
			
			$query .= " UPPER($key) LIKE :".strtoupper($key);
			$query .=  ($i != count($args)) ? " AND " : "";

			$array[":".strtoupper($key)] = "%".strtoupper($value)."%";
		
			$i++;
		}

		if (count($args) > 0) {
			$query .= " isDeleted = :ISDELETED ";
		} else {
			$query .= " WHERE isDeleted = :ISDELETED ";
		}

		$array[":ISDELETED"] = 0;

		$query .= " ORDER BY desName ASC ";

		return json_encode($sql->select($query, $array));		

	}

	public function listProductById($idProduct){

			$sql = new Sql();

			return json_encode($sql->select("SELECT * FROM tbProducts WHERE idProduct = :IDPRODUTO",[
					':IDPRODUTO' => $idProduct
			]));

	}

	public function createProduct(){

		$sql = new Sql();
		
		if($this->getDesName() != "" && $this->getVlUnity() != "" && $this->getIdCompany() != "" && $this->getIdProductCategory() != ""){

			$sql->query("INSERT INTO tbProducts(desName, desNote, desImagePath, isActive, vlUnity, idCompany, idProductCategory) 
						VALUES (:DESNAME, :DESNOTE, :DESIMAGEPATH, :ISACTIVE, :VLUNITY, :IDCOMPANY, :IDPRODUCTCATEGORY)", [
					":DESNAME"=>$this->getDesName(),
					":DESNOTE"=>$this->getDesNote(),
					":DESIMAGEPATH"=>$this->getDesImagePath(),
					":VLUNITY"=>$this->getVlUnity(),
					":ISACTIVE"=>$this->getIsActive(),
					":IDCOMPANY"=>$this->getIdCompany(),
					":IDPRODUCTCATEGORY"=>$this->getIdProductCategory()
				]);
		}

	}

	public function editProduct($id) {

		$sql = new Sql();
		
		if($this->getDesName() != "" && $this->getVlUnity() != "" && $this->getIdCompany() != "" && $this->getIdProductCategory() != ""){

			$sql->query("UPDATE tbProducts SET
							desName = :DESNAME, 
							desNote = :DESNOTE, 
							desImagePath = :DESIMAGEPATH, 
							isActive = :ISACTIVE, 
							vlUnity = :VLUNITY,
							idCompany = :IDCOMPANY,
							idProductCategory = :IDPRODUCTCATEGORY
						 WHERE
						 	idProduct = :IDPRODUCT", [
					":DESNAME"=>$this->getDesName(),
					":DESNOTE"=>$this->getDesNote(),
					":DESIMAGEPATH"=>$this->getDesImagePath(),
					":VLUNITY"=>$this->getVlUnity(),
					":ISACTIVE"=>$this->getIsActive(),
					":IDCOMPANY"=>$this->getIdCompany(),
					":IDPRODUCTCATEGORY"=>$this->getIdProductCategory(),
					":IDPRODUCT"=>$id
				]);
		}

	}

	public function deleteProduct($idProduct){

        $sql = new Sql();

        return $sql->query("UPDATE tbProducts SET isDeleted = :ISDELETED
                WHERE idCompany = :IDCOMPANY AND idProduct = :IDPRODUCT", [
                ":ISDELETED"=>$this->getIsDeleted(),
                ":IDCOMPANY"=>$this->getIdCompany(),
                ":IDPRODUCT"=>$idProduct                       
            ]);
    
	} 
	
	public function setAllPropertiesById($idProduct) {

		$sql = new Sql();

        $res = $sql->select("SELECT * FROM tbProducts 
                WHERE idCompany = :IDCOMPANY AND 
				idProduct = :IDPRODUCT", [
                ":IDCOMPANY"=>$this->getIdCompany(),
                ":IDPRODUCT"=>$idProduct                       
			])[0];
		
		$this->setIdProduct($idProduct);
		$this->setDesName($res['desName']);
		$this->setDesNote($res['desNote']);
		$this->setVlUnity($res['vlUnity']);
		$this->setIsActive($res['isActive']);
		$this->setIdProductCategory($res['idProductCategory']);

	}

}

?>