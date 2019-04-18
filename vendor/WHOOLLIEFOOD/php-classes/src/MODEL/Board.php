<?php
namespace WHOOLLIEFOOD\MODEL;
use \WHOOLLIEFOOD\DB\Sql;
class Board {
    private $idBoard;
    private $idCompany;
	private $vlBoard;
	private $qtPlaces;
	private $isActive;
	private $isDeleted;
	
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
	public function getIsDeleted() {
		return $this->isDeleted;
	}
	public function setIsDeleted($isDeleted) {
		$this->isDeleted = $isDeleted;
	}


    
    public function createBoard() {
        $sql = new Sql();
        
		$idBoard = $sql->query("
					INSERT INTO tbBoards(idCompany, vlBoard, qtPlaces) 
					VALUES (:IDCOMPANY, :VLBOARD, :QTPLACES)", [
					":IDCOMPANY"=>$this->getIdCompany(),
					":VLBOARD"=>$this->getVlBoard(),
					":QTPLACES"=>$this->getQtPlaces()
					
					]);

	   $this->setIdBoard($idBoard);
	   
	   	if ($idBoard > 0) {
			return json_encode([
				'error' => false
			]);
	   	} else {
			return json_encode([
				'error' => true,
				'message' => 'Erro ao cadastrar a mesa!',
			]);
	   }
		
    }
    
    public function listAllBoards() {

		$sql = new Sql();
		
        return json_encode($sql->select("
		                     SELECT *
							 FROM tbBoards
							 WHERE 
							 isDeleted = :ISDELETED AND
							 idCompany = :IDCOMPANY
                             ORDER BY vlBoard", [
								":ISDELETED" => 0,
								":IDCOMPANY" => $this->getIdCompany()
							]));
	}
	
	public function editBoard($id) {
		$sql = new Sql();
		
		if($this->getVlBoard() != "" && $this->getQtPlaces() != "" && $this->getIdCompany() != "" ){
	
			$sql->query("UPDATE tbBoards SET
							vlBoard = :VLBOARD, 
							qtPlaces = :QTPLACES
					
						 WHERE
							 idBoard = :IDBOARD", [
					":VLBOARD"=>$this->getVlBoard(),
					":QTPLACES"=>$this->getQtPlaces(),
					":IDBOARD"=>$id
				]);
		}
	
	}
	
	public function deleteBoard($idBoard){
	
		$sql = new Sql();
	
		return $sql->query("UPDATE tbBoards SET isDeleted = :ISDELETED
				WHERE idCompany = :IDCOMPANY AND idBoard = :IDBOARD", [
				":ISDELETED"=>$this->getIsDeleted(),
				":IDCOMPANY"=>$this->getIdCompany(),
				":IDBOARD"=>$idBoard                       
			]);
	
	} 
}
?>