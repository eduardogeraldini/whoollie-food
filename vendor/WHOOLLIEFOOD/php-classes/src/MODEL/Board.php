<?php

namespace WHOOLLIEFOOD\MODEL;

use \WHOOLLIEFOOD\DB\Sql;

class Board {

    private $idBoard;
    private $idCompany;
	private $vlBoard;
	private $qtPlaces;
	
	private $isActive;

    public function __construct(){
		$this->idCompany = $_SESSION['User']['idCompany'];
	}

	public function getIdBoard() {
		return $this->idBoard;
	}

	public function setIdBoard($idBoard) {
		$this->idBoard = $idBoard;
	}

	public function getIdCompany() {
		return $this->idCompany;
	}

	public function setIdCompany($idCompany) {
		$this->idCompany = $idCompany;
	}

	public function getVlBoard() {
		return $this->vlBoard;
	}

	public function setVlBoard($vlBoard) {
		$this->vlBoard = $vlBoard;
	}

	public function getQtPlaces() {
		return $this->qtPlaces;
	}

	public function setQtPlaces($qtPlaces) {
		$this->qtPlaces = $qtPlaces;
	}


	public function getIsActive() {
		return $this->isActive;
	}

	public function setIsActive($isActive) {
		$this->isActive = $isActive;
    }
    
    public function createBoard() {

        $sql = new Sql();
        
		$idBoard = $sql->query("INSERT INTO tbBoards(idCompany, vlBoard, qtPlaces) 
						    VALUES (:IDCOMPANY, :VLBOARD, :QTPLACES)", [
                            ":IDCOMPANY"=>$this->getIdCompany(),
                            ":VLBOARD"=>$this->getVlBoard(),
                            ":QTPLACES"=>$this->getQtPlaces()
                           
							]);

       $this->setIdBoard($idBoard);

		
    }
    
    public function listAllBoards() {

        $sql = new Sql();

        return json_encode($sql->select("SELECT *
                             FROM tbBoards
                             ORDER BY vlBoard"));

    }


}

?>