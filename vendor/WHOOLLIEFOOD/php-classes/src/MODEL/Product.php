<?php

namespace WHOOLLIEFOOD\MODEL;

use \WHOOLLIEFOOD\DB\Sql;

class Product{

	private $desName;
	private $desNote;
	private $vlUnity;
	private $qtStock;
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

	public function listAll(){

		$sql = new Sql();

		return json_encode($sql->select("SELECT * FROM tbProducts"));

    }

    public function listProductById($id){

        $sql = new Sql();

		return json_encode($sql->select("SELECT * FROM tbProducts WHERE idProduct = :IDPRODUTO",[
            ':IDPRODUTO' => $id
        ]));

    }

    public function createProduct(){

        $sql = new Sql();

		echo "INSERT INTO tbProducts(desName, desNote, qtStock, vlUnity, idCompany, idProductCategory) 
		VALUES ('".$this->getDesName()."', '".$this->getDesNote()."', '".$this->getQtStock()."', '".$this->getVlUnity()."', '".$this->getIdCompany()."', '".$this->getIdProductCategory()."')";

		$sql->query("INSERT INTO tbProducts(desName, desNote, qtStock, vlUnity, idCompany, idProductCategory) 
			VALUES (:DESNAME, :DESNOTE, :QTSTOCK, :VLUNITY, :IDCOMPANY, :IDPRODUCTCATEGORY)", [
				":DESNAME"=>$this->getDesName(),
				":DESNOTE"=>$this->getDesNote(),
                ":QTSTOCK"=>$this->getQtStock(),
                ":VLUNITY"=>$this->getVlUnity(),
				":IDCOMPANY"=> $this->getIdCompany(),
				":IDPRODUCTCATEGORY"=> $this->getIdProductCategory()
			]);
	}


}

?>