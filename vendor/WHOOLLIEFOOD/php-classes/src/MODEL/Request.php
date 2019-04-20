<?php

namespace WHOOLLIEFOOD\MODEL;

use \WHOOLLIEFOOD\DB\Sql;
use \WHOOLLIEFOOD\MODEL\Cart;
use \PUSHER\Pusher;

class Request {

	private $idCompany;
	private $idOrder;
    private $idRequest;
    
	private $options;
	private $pusher;
	private $desChannel;
    
	public function __construct() {
        
        $this->setIdCompany($_SESSION['User']['idCompany']);
        $this->setIdOrder($_SESSION["Order"]["id"]);
        $this->setDesChannel($_SESSION["User"]["desChannel"]);

        $this->options = array(
            'cluster' => 'us2',
            'useTLS' => true
        );

        $this->pusher = new Pusher(
            '7a6218b4df87abcc1c7c',
            '6a18bec5a755ce4407a2',
            '746032',
            $this->options
        );

    }

    public function setIdCompany($value) {
        $this->idCompany = $value;
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

    public function setDesChannel($value) {
        $this->desChannel = $value;
    }

    public function getDesChannel() {
        return $this->desChannel;
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

        $data['message'] = 'Novo pedido adicionado';
        $this->pusher->trigger($this->getDesChannel(), 'new-request', $data);

        $cart->clearCart();

    }

    public function listRequestsByOrders(){

        $sql = new Sql();

		return json_encode($sql->select("
			SELECT * 
			FROM tbRequests
			WHERE 
			isDeleted = :ISDELETED AND
            idOrder = :IDORDER
            ORDER BY dtRegister ASC", [
				":ISDELETED" => 0,
                ":IDORDER" => $this->getIdOrder()
			]));

    }
    
    public function listProductsInRequest(){

        $sql = new Sql();

        return json_encode($sql->select("
            SELECT a.idRequestProduct, a.idRequest, a.idProduct, a.qtProduct, a.vlUnity, a.dtRegister, b.idProduct, b.desName 
            FROM tbrequestsproducts a 
            INNER JOIN tbproducts b 
            ON(a.idProduct = b.idProduct) 
            WHERE a.idRequest = :IDREQUEST", [
                ":IDREQUEST" => $this->getIdRequest()
            ]));
    }

}

?>