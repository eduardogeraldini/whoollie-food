<?php

namespace WHOOLLIEFOOD\MODEL;

use \WHOOLLIEFOOD\DB\Sql;

class Ingredient {

    private $idIngredient;
    private $idProduct;
	private $desName;
	private $vlUnity;
	private $isActive;
	private $isDeleted;
	private $idCompany;
	private $idMeasurement;
	private $qtIngredient;
	private $idIngredientProduct;

	public function __construct(){
		if (isset($_SESSION['User']['idCompany']))
			$this->idCompany = $_SESSION['User']['idCompany'];
		else
			$this->idCompany = $_SESSION['Device']['idCompany'];
	}
    
    public function setIdIngredient($idIngredient) {
		$this->idIngredient = $idIngredient;
	}

	public function setDesName($desName){
		$this->desName = $desName;
	}

	public function setVlUnity($vlUnity){
		$this->vlUnity = valueToSave($vlUnity);
	}
	public function setIsActive($isActive) {
		$this->isActive = $isActive;
	}

	public function setIsDeleted($isDeleted) {
		$this->isDeleted = $isDeleted;
	}

	public function setIdCompany($idCompany) {
		$this->idCompany = $idCompany;
	}
	
	public function setIdProduct($idProduct) {
		$this->idProduct = $idProduct;
	}

	public function setIdMeasurement($idMeasurement) {
		$this->idMeasurement = $idMeasurement;
	}

	public function setQtIngredient($qtIngredient) {
		$this->qtIngredient = $qtIngredient;
	}
	
	public function setIdIngredientProduct($idIngredientProduct) {
		$this->idIngredientProduct = $idIngredientProduct;
	}
    
    public function getIdIngredient(){
		return $this->idIngredient;
	}

	public function getDesName(){
		return $this->desName;
	}

	public function getVlUnity(){
		return $this->vlUnity;
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
	
	public function getIdProduct(){
		return $this->idProduct;
	}

	public function getIdMeasurement() {
		return $this->idMeasurement;
	}

	public function getQtIngredient() {
		return $this->qtIngredient;
	}

	public function getIdIngredientProduct() {
		return $this->idIngredientProduct;
	}

	public function listAll() {

		$sql = new Sql();
		
		return json_encode($sql->select("
				SELECT i.*, m.desName AS 'desShort' 
				FROM tbIngredients i
				INNER JOIN tbMeasurements m ON (i.idMeasurement = m.idMeasurement)
				WHERE 
				i.isDeleted = :ISDELETED AND
				i.idCompany = :IDCOMPANY
				ORDER BY i.desName ASC", [
					":ISDELETED" => $this->getIsDeleted(),
					":IDCOMPANY" => $this->getIdCompany()
			]));

	}

	public function listIngredientById(){

			$sql = new Sql();

			return json_encode($sql->select("
								SELECT i.*, m.desName AS 'desShort' 
								FROM tbIngredients i
								INNER JOIN tbMeasurements m ON (i.idMeasurement = m.idMeasurement)
								WHERE i.idIngredient = :IDINGREDIENT",[
					':IDINGREDIENT' => $this->getIdIngredient()
			]));

	}

	public function createIngredient(){

		$sql = new Sql();

		if($this->getDesName() != "" && $this->getIdCompany() != ""){

			$sql->query("INSERT INTO tbIngredients(idCompany, idMeasurement, desName, isActive) 
						VALUES (:IDCOMPANY, :IDMEASUREMENT, :DESNAME, :ISACTIVE)", [
                    ":IDCOMPANY"=>$this->getIdCompany(),
					":DESNAME"=>$this->getDesName(),
					":IDMEASUREMENT"=>$this->getIdMeasurement(),
					":ISACTIVE"=>$this->getIsActive()
                ]);

            return json_encode([
                "error" => false
            ]);
                
        }
        
        return json_encode([
            "error" => true,
            "message" => "Falha ao criar ingrediente!"
        ]);

	}

	public function editIngredient() {

		$sql = new Sql();
		
		if($this->getDesName() != "" && $this->getIdCompany() != ""){

			$sql->query("UPDATE tbIngredients SET
							desName = :DESNAME, 
							isActive = :ISACTIVE, 
							idMeasurement = :IDMEASUREMENT,
							idCompany = :IDCOMPANY
						 WHERE
                         idIngredient = :IDINGREDIENT", [
					":DESNAME"=>$this->getDesName(),
					":ISACTIVE"=>$this->getIsActive(),
					":IDCOMPANY"=>$this->getIdCompany(),
					":IDMEASUREMENT"=>$this->getIdMeasurement(),
					":IDINGREDIENT"=>$this->getIdIngredient()
                ]);

            return json_encode([
                "error" => false
            ]);
                
        }
        
        return json_encode([
            "error" => true,
            "message" => "Falha ao editar ingrediente!"
        ]);

	}

	public function hasRelations($idIngredient) {

		$sql = new Sql();

        $res = $sql->select("SELECT COUNT(idIngredient) AS 'TOTAL'
							FROM tbIngredientsProducts
							WHERE 
							idIngredient = :IDINGREDIENT", [
                ":IDINGREDIENT"=>$idIngredient                       
		]);
		
		if((int)$res[0]["TOTAL"] > 0) {
			return true;
		} else {
			return false;
		}

	}

	public function deleteIngredient(){

		$sql = new Sql();
		
		if ($this->hasRelations(getIdIngredient())) {
			return json_encode(["error" => true, "message" => "O ingrediente está relacionado a um ou mais produtos. Não será possível excluí-lo!"]);
		}

        return $sql->query("UPDATE tbIngredients SET 
                            isDeleted = :ISDELETED
                            WHERE 
                            idCompany = :IDCOMPANY AND 
                            idIngredient = :IDINGREDIENT", [
                ":ISDELETED"=>$this->getIsDeleted(),
                ":IDCOMPANY"=>$this->getIdCompany(),
                ":IDINGREDIENT"=>$this->getIdIngredient()                      
			]);
			
		return json_encode(["error" => false]);
    
	} 

	public function getUnrelatedIngredientsByProduct() {

		$sql = new Sql();

		return json_encode($sql->select("
			SELECT i.*, m.desName AS 'desShort' 
			FROM tbIngredients i
			INNER JOIN tbMeasurements m ON (i.idMeasurement = m.idMeasurement)
			WHERE
			i.idCompany = :IDCOMPANY AND
			i.isDeleted = :ISDELETED AND
			idIngredient NOT IN (
				SELECT idIngredient
				FROM tbIngredientsProducts
				WHERE 
				idProduct = :IDPRODUCT
			)
		", [
			":IDPRODUCT"=>$this->getIdProduct(),
			":ISDELETED"=>$this->getIsDeleted(),
			":IDCOMPANY"=>$this->getIdCompany()
		]));

	}

	public function getRelatedIngredientsByProduct() {

		$sql = new Sql();

		return json_encode($sql->select("
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
			) AND
			ip.idProduct = :IDPRODUCT
		", [
			":IDPRODUCT"=>$this->getIdProduct(),
			":ISDELETED"=>$this->getIsDeleted(),
			":IDCOMPANY"=>$this->getIdCompany()
		]));

	}

	public function addIngredientToProduct() {

		$sql = new Sql();

        $sql->query("INSERT INTO tbIngredientsProducts(idProduct, idIngredient, qtIngredient) 
                            VALUES(:IDPRODUCT, :IDINGREDIENT, :QTINGREDIENT);", [
                ":IDPRODUCT"=>$this->getIdProduct(),
                ":IDINGREDIENT"=>$this->getIdIngredient(),
				":QTINGREDIENT"=>$this->getQtIngredient()               
		]);
			
		return json_encode([
			"error" => false
		]);
    

	}

	public function removeIngredientByProduct() {

		$sql = new Sql();

        $sql->query("DELETE FROM tbIngredientsProducts
							WHERE 
							idIngredientProduct = :IDINGREDIENTPRODUCT;", [
                ":IDINGREDIENTPRODUCT"=>$this->getIdIngredientProduct()            
		]);
		
		return json_encode([
			"error" => false
		]);

	}

}

?>