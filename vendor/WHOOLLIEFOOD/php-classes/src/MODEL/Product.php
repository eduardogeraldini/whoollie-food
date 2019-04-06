<?php

namespace WHOOLLIEFOOD\MODEL;

use \WHOOLLIEFOOD\DB\Sql;

class Product{

	private $desName;
	private $desNote;
	private $desImagePath;
	private $vlUnity;
	private $qtStock;
	private $isActive;
	private $idCompany;
	private $idProductCategory;

	public function __construct(){

		$this->idCompany = $_SESSION['User']['idCompany'];

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

	public function setQtStock($qtStock){
		$this->qtStock = $qtStock;
	}

	public function setIdProductCategory($idProductCategory){
		$this->idProductCategory = $idProductCategory;
	}

	public function setIsActive($isActive) {
		$this->isActive = $isActive;
	}

	public function setDesImagePath($files) {

		if ($files["image"]["name"] == "") {
			$this->desImagePath = "res/admin/img/sem_foto.png";
			
			echo json_encode([
				'error' => false
			]);
				
			return;
		}
		
		$target_dir = "res/uploads/products/";
		$target_file = $target_dir . time() . "_" . basename($files["image"]["name"]);
		$imageFileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));
		
		if(getimagesize($files["image"]["tmp_name"]) === false) {
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

		if ($files["image"]["size"] > 5 * 1024 * 1024) {
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

		if (move_uploaded_file($files["image"]["tmp_name"], $target_file)) {
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

	public function getQtStock(){
		return $this->qtStock;
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

	public function getDesImagePath() {
		return $this->desImagePath;
	}

	public function listAll(){

		$sql = new Sql();

		return json_encode($sql->select("SELECT * FROM tbProducts"));

    }

    public function listProductById($idProduct){

        $sql = new Sql();

				return json_encode($sql->select("SELECT * FROM tbProducts WHERE idProduct = :IDPRODUTO",[
            ':IDPRODUTO' => $idProduct
        ]));

		}

    public function createProduct(){

		$sql = new Sql();
		
		if($this->getDesName() != "" && $this->getVlUnity() != "" && $this->getQtStock() != "" && $this->getIdCompany() != "" && $this->getIdProductCategory() != ""){

			$sql->query("INSERT INTO tbProducts(desName, desNote, desImagePath, qtStock, isActive, vlUnity, idCompany, idProductCategory) 
						 VALUES (:DESNAME, :DESNOTE, :DESIMAGEPATH, :QTSTOCK, :ISACTIVE, :VLUNITY, :IDCOMPANY, :IDPRODUCTCATEGORY)", [
					":DESNAME"=>$this->getDesName(),
					":DESNOTE"=>$this->getDesNote(),
					":DESIMAGEPATH"=>$this->getDesImagePath(),
					":QTSTOCK"=>$this->getQtStock(),
					":VLUNITY"=>$this->getVlUnity(),
					":ISACTIVE"=>$this->getIsActive(),
					":IDCOMPANY"=>$this->getIdCompany(),
					":IDPRODUCTCATEGORY"=>$this->getIdProductCategory()
				]);
		}

	}


}

?>