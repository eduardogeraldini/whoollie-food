<?php

namespace WHOOLLIEFOOD\MODEL;

use \WHOOLLIEFOOD\DB\Sql;
use \WHOOLLIEFOOD\MODEL\Product;

class Order {

	private $idCompany;
	private $idUser;
	private $idOrder;
	private $idBoard;
	private $desName;
	private $vlDiscount;
    
	public function __construct() {
        $this->idCompany = $_SESSION['User']['idCompany'];
        
        if (isset($_SESSION['User']['idUser']))
			$this->idUser = $_SESSION['User']['idUser'];
		else
			$this->idUser = $_SESSION['Device']['idDevice'];
    }

    public function setIdCompany($value) {
        $this->idCompany = $idCompany;
    }

    public function getIdCompany() {
        return $this->idCompany;
    }

    public function setIdUser($value) {
        $this->idUser = $value;
    }

    public function getIdUser() {
        return $this->idUser;
    }

    public function setIdOrder($value) {
        $this->idOrder = $value;
        $_SESSION["Order"]["id"] = $value;
    }

    public function setVlStatus($value) {
        $this->vlStatus = $value;
    }

    public function getIdOrder() {
        return $this->idOrder;
    }

    public function setIdBoard($value) {
        $this->idBoard = $value;
    }

    public function getIdBoard() {
        return $this->idBoard;
    }

    public function setVlDiscount($value) {
        $this->vlDicount = $value;
    }

    public function getVlDiscount() {
        return $this->vlDicount;
    }
    
    public function setDesName($value) {
        $this->desName = $value;
    }

    public function getDesName() {
        return $this->desName;
    }

    public function getVlStatus() {
        return $this->vlStatus;
    }

    public function openedOrder() {

        if (isset($_SESSION["Order"]["id"])) {
            if ($_SESSION["Order"]["id"] != "")
                return ["open" => true];
            else
                return ["open" => false];
        } else { 
            return ["open" => false];
        }

    }

    public function openNewOrder() {

        $sql = new Sql();

        $idOrder = $sql->query("INSERT INTO tbOrders(idCompany, idUser, idBoard, desName)
                    VALUES (:IDCOMPANY, :IDUSER, :IDBOARD, :DESNAME)", [
                        ":IDCOMPANY"=>$this->getIdCompany(), 
                        ":IDUSER"=>$this->getIdUser(), 
                        ":IDBOARD"=>$this->getIdBoard(), 
                        ":DESNAME"=>$this->getDesName()
                    ]);

        $this->setIdOrder($idOrder);

        return json_encode([
            "idOrder"=>$this->getIdOrder(),
            "idBoard"=>$this->getIdBoard(),
            "desName"=>$this->getDesName()
        ]);

    }

    public function requestsQuantityOrder() {

        $sql = new Sql();

        $result = $sql->select("SELECT count(vlStatus) AS 'total' 
                    FROM tbRequests 
                    WHERE
                    vlStatus = :VLSTATUS AND
                    idOrder = :IDORDER", [
                        ":VLSTATUS"=>0,
                        ":IDORDER"=>$this->getIdOrder()
                    ]);

        return $result[0]['total'];

    }

    public function returnPriceByOrders() {

        $sql = new Sql();

        $result = $sql->select("SELECT SUM(qtProduct*vlUnity) as total FROM tbRequests a INNER JOIN tbrequestsproducts b ON(a.idRequest = b.idRequest) WHERE a.idOrder = :IDORDER", [
                        ":IDORDER"=>$this->getIdOrder()
                    ]);

        return json_encode($result[0]);

    }

    public function closeOrder() {

        $sql = new Sql();

        if (((int) $this->requestsQuantityOrder()) == 0) {

            $sql->query("UPDATE tbOrders SET
                        vlStatus = :VLSTATUS
                        WHERE
                        idOrder = :IDORDER", [
                            ":VLSTATUS"=>$this->getVlStatus(),
                            ":IDORDER"=>$this->getIdOrder()
                        ]);

            $this->setIdOrder("");

            return json_encode([
				'error' => false
			]);
        
        } else {

            return json_encode([
				'error' => true,
				"message" => "Há pedidos pendentes para essa comanda, verifique com a cozinha!"
			]);

        }
        
    } 
    
    public function listOrderById($idOrder){

        $sql = new Sql();

        return json_encode($sql->select("SELECT * FROM tbOrders WHERE idOrder = :IDORDER",[
                ':IDORDER' => $idOrder
        ]));

    }

    public function listAll(){

		$sql = new Sql();

		return json_encode($sql->select("
			SELECT * 
			FROM tbOrders
			WHERE 
			isDeleted = :ISDELETED AND
			idCompany = :IDCOMPANY
			ORDER BY idOrder ASC", [
				":ISDELETED" => 0,
				":IDCOMPANY" => $this->getIdCompany()
			]));

	}

}

?>