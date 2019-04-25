<?php

namespace WHOOLLIEFOOD\MODEL;

use \WHOOLLIEFOOD\DB\Sql;

class Ingredient {

    private $idIngredient;
	private $desName;
	private $vlUnity;
	private $isActive;
	private $isDeleted;
	private $idCompany;

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

	public function listAll() {

		$sql = new Sql();
		
		return json_encode($sql->select("
				SELECT * 
				FROM tbIngredients
				WHERE 
				isDeleted = :ISDELETED AND
				idCompany = :IDCOMPANY
				ORDER BY desName ASC", [
					":ISDELETED" => $this->getIsDeleted(),
					":IDCOMPANY" => $this->getIdCompany()
			]));

	}

	public function listIngredientById(){

			$sql = new Sql();

			return json_encode($sql->select("SELECT * FROM tbIngredients WHERE idIngredient = :IDINGREDIENT",[
					':IDINGREDIENT' => $this->getIdIngredient()
			]));

	}

	public function createIngredient(){

		$sql = new Sql();

		if($this->getDesName() != "" && $this->getVlUnity() != "" && $this->getIdCompany() != ""){

			$sql->query("INSERT INTO tbIngredients(idCompany, desName, vlUnity, isActive) 
						VALUES (:IDCOMPANY, :DESNAME, :VLUNITY, :ISACTIVE)", [
                    ":IDCOMPANY"=>$this->getIdCompany(),
					":DESNAME"=>$this->getDesName(),
					":VLUNITY"=>$this->getVlUnity(),
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
		
		if($this->getDesName() != "" && $this->getVlUnity() != "" && $this->getIdCompany() != ""){

			$sql->query("UPDATE tbIngredients SET
							desName = :DESNAME, 
                            vlUnity = :VLUNITY,
							isActive = :ISACTIVE, 
							idCompany = :IDCOMPANY
						 WHERE
                         idIngredient = :IDINGREDIENT", [
					":DESNAME"=>$this->getDesName(),
					":VLUNITY"=>$this->getVlUnity(),
					":ISACTIVE"=>$this->getIsActive(),
					":IDCOMPANY"=>$this->getIdCompany(),
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

	public function deleteIngredient(){

        $sql = new Sql();

        return $sql->query("UPDATE tbIngredients SET 
                            isDeleted = :ISDELETED
                            WHERE 
                            idCompany = :IDCOMPANY AND 
                            idIngredient = :IDINGREDIENT", [
                ":ISDELETED"=>$this->getIsDeleted(),
                ":IDCOMPANY"=>$this->getIdCompany(),
                ":IDINGREDIENT"=>$this->getIdIngredient()                      
            ]);
    
	} 

}

?>