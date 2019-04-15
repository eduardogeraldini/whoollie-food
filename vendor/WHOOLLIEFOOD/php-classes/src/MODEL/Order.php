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
        $this->idUser = $_SESSION['User']["idUser"];
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
        $_SESSION["Order"]["id"] = $this->idOrder;
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

    public function closeOrder() {

        $sql = new Sql();

        $sql->query("UPDATE tbOrders SET
                    vlStatus = :VLSTATUS
                    WHERE
                    idOrder = :IDORDER", [
                        ":VLSTATUS"=>$this->getVlStatus(),
                        ":IDORDER"=>$this->getIdOrder()
                    ]);

        $this->setIdOrder("");
        
    }   

}

?>