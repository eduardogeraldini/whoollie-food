<?php

namespace WHOOLLIEFOOD\MODEL;

use \WHOOLLIEFOOD\DB\Sql;
use \WHOOLLIEFOOD\MODEL\Cart;

class Request {

	private $idCompany;
	private $idOrder;
	private $idRequest;
    
	public function __construct() {
        $this->idCompany = $_SESSION['User']['idCompany'];
        $this->idOrder = $_SESSION["Order"]["id"];
    }

    public function setIdCompany($value) {
        $this->idCompany = $idCompany;
    }

    public function getIdCompany() {
        return $this->idCompany;
    }

    public function setIdOrder($value) {
        $this->idOrder = $value;
    }

    public function getIdOrder() {
        return $this->idOrder;
    }

    public function setIdRequest($value) {
        $this->idRequest = $value;
    }

    public function getIdRequest() {
        return $this->idRequest;
    }

    public function openNewRequest() {

        $sql = new Sql();

        $idRequest = $sql->query("INSERT INTO tbRequests(idOrder)
                    VALUES (:IDORDER)", [
                        ":IDORDER"=>$this->getIdOrder()
                    ]);

        $this->setIdRequest($idRequest);
        $this->saveNewRequest();

    }

    public function saveNewRequest() {

        $sql = new Sql();

        $cart = new Cart();
        $products = $cart->getProducts();

        foreach ($products as $key => $value) {

            $sql->query("INSERT INTO tbRequestsProducts(idRequest, idProduct, qtProduct, vlUnity)
                        VALUES (:IDREQUEST, :IDPRODUCT, :QTPRODUCT, :VLUNITY)", [
                ":IDREQUEST"=>$this->getIdRequest(),
                ":IDPRODUCT"=>$key,
                ":QTPRODUCT"=>$value["qtTotal"],
                ":VLUNITY"=>$value["vlUnity"]
            ]);

        }

        $cart->clearCart();

    }

}

?>