<?php

namespace WHOOLLIEFOOD\MODEL;

use \WHOOLLIEFOOD\DB\Sql;

class Product{

	private $limit;
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

	public function setLimit($limit) {
		$this->limit = $limit;
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

	public function getLimit() {
		return $this->limit;
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

	/*public function listProductById($idProduct){

		$sql = new Sql();

		$products = $sql->select("SELECT * 
									FROM tbProducts 
									WHERE idProduct = :IDPRODUCT AND
									idCompany = :IDCOMPANY",[
				':IDPRODUCT' => $idProduct,
				':IDCOMPANY' => $this->getIdCompany()
		]);

		$arr = [];
		$i = 0;

		foreach ($products as $key) {
			$arr[$i]["idProduct"] = $key["idProduct"];
			$arr[$i]["idCompany"] = $key["idCompany"];
			$arr[$i]["idProductCategory"] = $key["idProductCategory"];
			$arr[$i]["vlUnity"] = $key["vlUnity"];
			$arr[$i]["desName"] = $key["desName"];
			$arr[$i]["desNote"] = $key["desNote"];
			$arr[$i]["desImagePath"] = $key["desImagePath"];
			$arr[$i]["isActive"] = $key["isActive"];
			$arr[$i]["dtRegister"] = $key["dtRegister"];
			$arr[$i]["isDeleted"] = $key["isDeleted"];			
			
			$ingredients = $sql->select("
				SELECT i.*, ip.idIngredientProduct, ip.qtIngredient, ip.idProduct, m.desName AS 'desShort'
				FROM tbIngredients i
				INNER JOIN tbIngredientsProducts ip ON (i.idIngredient = ip.idIngredient)
				INNER JOIN tbMeasurements m ON (i.idMeasurement = m.idMeasurement)
				WHERE
				i.idCompany = :IDCOMPANY AND
				i.isDeleted = :ISDELETED AND
				i.idIngredient IN (
					SELECT idIngredient
					FROM tbIngredientsProducts
					WHERE 
					idProduct = :IDPRODUCT
				)
			",[
				":IDCOMPANY" => $this->getIdCompany(),
				":ISDELETED" => 0,
				':IDPRODUCT' => $idProduct
			]);
			
			$j = 0;

			$arr[$i]["listIngredients"] = false;

			foreach ($ingredients as $key) {
				$arr[$i]["listIngredients"][$j]["idIngredient"] = $key["idIngredient"];
				$arr[$i]["listIngredients"][$j]["desName"] = $key["desName"];
				$arr[$i]["listIngredients"][$j]["qtIngredient"] = $key["qtIngredient"];
				$arr[$i]["listIngredients"][$j]["desShort"] = $key["desShort"];

				$j++;
			}
		}

		return json_encode($arr);

	}*/

	public function listProductById($idProduct){

		$sql = new Sql();

		$products = $sql->select("SELECT * 
									FROM tbProducts 
									WHERE idProduct = :IDPRODUCT AND
									idCompany = :IDCOMPANY",[
				':IDPRODUCT' => $idProduct,
				':IDCOMPANY' => $this->getIdCompany()
		]);
		
			
			$ingredients = $sql->select("
				SELECT i.*, ip.idIngredientProduct, ip.qtIngredient, ip.idProduct, m.desName AS 'desShort'
				FROM tbIngredients i
				INNER JOIN tbIngredientsProducts ip ON (i.idIngredient = ip.idIngredient)
				INNER JOIN tbMeasurements m ON (i.idMeasurement = m.idMeasurement)
				WHERE
				ip.idProduct = :IDPRODUCT AND
				i.idCompany = :IDCOMPANY AND
				i.isDeleted = :ISDELETED AND
				i.idIngredient IN (
					SELECT idIngredient
					FROM tbIngredientsProducts
					WHERE 
					idProduct = :IDPRODUCT
				)
			",[
				":IDCOMPANY" => $this->getIdCompany(),
				":ISDELETED" => 0,
				':IDPRODUCT' => $idProduct
			]);
			
		$products[0]['listIngredients'] = $ingredients;

		return json_encode($products);

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

	public function hasRelations($idProduct) {

		$sql = new Sql();

        $res = $sql->select("SELECT COUNT(idRequestProduct) AS 'TOTAL'
					  FROM tbRequestsProducts
					  WHERE 
					  idProduct = :IDPRODUCT", [
                ":IDPRODUCT"=>$idProduct                       
		]);
		
		if((int)$res[0]["TOTAL"] > 0) {
			return true;
		} else {
			return false;
		}

	}

	public function deleteProduct($idProduct){

        $sql = new Sql();

		if ($this->hasRelations($idProduct)) {
			return json_encode(["error" => true, "message" => "O produto está relacionado a um ou mais pedidos. Não será possível excluí-lo!"]);
		}

        $sql->query("UPDATE tbProducts SET isDeleted = :ISDELETED
                WHERE idCompany = :IDCOMPANY AND idProduct = :IDPRODUCT", [
                ":ISDELETED"=>$this->getIsDeleted(),
                ":IDCOMPANY"=>$this->getIdCompany(),
                ":IDPRODUCT"=>$idProduct                       
            ]);
	
		return json_encode(["error" => false]);

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

	public function listBestSellingProducts() {

		$sql = new Sql();

		return json_encode($sql->select("SELECT rp.idProduct, p.desName, SUM(rp.qtProduct) AS 'total'
							 FROM tbRequestsProducts rp
							 INNER JOIN tbProducts p ON (rp.idProduct = p.idProduct) 
							 WHERE 
							 p.isDeleted = :ISDELETED AND
							 p.idCompany = :IDCOMPANY
							 GROUP BY rp.idProduct
							 ORDER BY TOTAL DESC
							 LIMIT ".$this->getLimit().";", [
                ":IDCOMPANY"=>$this->getIdCompany(),
				":ISDELETED"=>$this->getIsDeleted()                   
			]));

	}

	public function listSalesInTheLastDays($days) {

		$sql = new Sql();

		return json_encode($sql->select("SELECT DAY(a.dtregister) AS DAY, SUM(a.qtProduct*a.vlUnity) AS TOTAL 
							FROM tbRequestsProducts a 
							INNER JOIN tbRequests b ON(a.idRequest = b.idRequest)
							INNER JOIN tbOrders c ON(b.idOrder = c.idOrder)
							WHERE a.isDeleted = :ISDELETED AND 
							b.vlStatus = :VLSTATUS AND
							c.idCompany = :IDCOMPANY AND
							a.dtRegister BETWEEN  DATE_ADD(SYSDATE(), INTERVAL -".$days." DAY) AND SYSDATE() 
							GROUP BY(DAY(a.dtRegister)) ORDER BY a.dtRegister ASC", [
				":ISDELETED"=>$this->getIsDeleted(),   
				":VLSTATUS"=>1,
				":IDCOMPANY"=>$this->getIdCompany()   
			]));

	}

}

?>