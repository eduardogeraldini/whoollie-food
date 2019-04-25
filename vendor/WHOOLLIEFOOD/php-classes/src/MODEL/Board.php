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
		
		

		$isCreated = $sql->select(" 
				SELECT * FROM  tbBoards
				WHERE 
					vlBoard = :VLBOARD AND
					isDeleted = :ISDELETED AND
					idCompany = :IDCOMPANY
					", [
					":VLBOARD"=>$this->getVlBoard(),
					":ISDELETED" => 0,
					":IDCOMPANY" => $this->getIdCompany()
				]);
						
		if(count($isCreated) > 0){ //se a query retornar uma linha, quer dizer que já foi criado uma mesa nesse numero

			return json_encode([
				'error' => true,
				'message' => 'Mesa já cadastrada!',
			]);
		}
		else{
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


		
    }
    
    public function listAllBoards() {

		$sql = new Sql();
		
        return json_encode($sql->select("
		                     SELECT *
							 FROM tbBoards
							 WHERE 
							 isDeleted = :ISDELETED AND
							 idCompany = :IDCOMPANY
                             ORDER BY vlBoard ASC", [
								":ISDELETED" => 0,
								":IDCOMPANY" => $this->getIdCompany()
							]));
	}

	public function listBoardById($idBoard){

		$sql = new Sql();

		return json_encode($sql->select("SELECT * FROM tbBoards WHERE idBoard = :IDBOARD",[
				':IDBOARD' => $idBoard
		]));

    }
	
	public function editBoard() {
		
		$sql = new Sql();
		
		if($this->getVlBoard() != "" && $this->getQtPlaces() != "" && $this->getIdCompany() != ""){
	
			$sql->query("UPDATE tbBoards 
							SET
								vlBoard = :VLBOARD, 
								qtPlaces = :QTPLACES
					
						 WHERE
							 idBoard = :IDBOARD", [
								":IDBOARD"=>$this->getIdBoard(),
								":VLBOARD"=>$this->getVlBoard(),
								":QTPLACES"=>$this->getQtPlaces(),
						]);

						echo json_encode([
							'error' => false
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