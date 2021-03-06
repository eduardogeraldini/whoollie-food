<?php

namespace WHOOLLIEFOOD\MODEL;

use \WHOOLLIEFOOD\DB\Sql;
use \WHOOLLIEFOOD\MODEL\Cart;
use \PUSHER\Pusher;

class Request {

	private $idCompany;
	private $idOrder;
    private $idRequest;
    private $desNote;
    private $vlStatus;
    
	private $options;
	private $pusher;
	private $desChannel;
    
	public function __construct() {
        
        if (isset($_SESSION['User'])) {
            $this->setIdCompany($_SESSION['User']['idCompany']);
            $this->setDesChannel($_SESSION["User"]["desChannel"]);
        }

        if (isset($_SESSION["Order"]))
            $this->setIdOrder($_SESSION["Order"]["id"]);
        
        if (isset($_SESSION['Device'])) {
            $this->setIdCompany($_SESSION['Device']['idCompany']);
            $this->setDesChannel($_SESSION["Device"]["desChannel"]);
        }

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

    public function setDesNote($value) {
        $this->desNote = $value;
    }

    public function getDesNote() {
        return $this->desNote;
    }

    public function setDesChannel($value) {
        $this->desChannel = $value;
    }

    public function getDesChannel() {
        return $this->desChannel;
    }

    public function setVlStatus($vlStatus) {
        $this->vlStatus = $vlStatus;
    }

    public function getVlStatus() {
        return $this->vlStatus;
    }

    public function listAll() {
        
        $sql = new Sql();

        return json_encode($sql->select("SELECT *, o.desName AS 'desRequester', r.dtRegister AS 'dtRegisterRequest'
                                        FROM tbRequests r
                                        INNER JOIN tbOrders o ON (r.idOrder = o.idOrder)
                                        INNER JOIN tbBoards b ON (o.idBoard = b.idBoard)
                                        WHERE r.vlStatus = :VLSTATUS
                                        ORDER BY r.dtRegister ASC", [
                                            ":VLSTATUS"=>$this->getVlStatus()
                                        ]));

    }

    public function listProductsByRequest() {

        $sql = new Sql();

        return json_encode($sql->select("SELECT *
                                        FROM tbRequestsProducts rp
                                        INNER JOIN tbProducts p ON (rp.idProduct = p.idProduct)
                                        WHERE rp.idRequest = :IDREQUEST
                                        ORDER BY p.desName ASC", [
                                            ":IDREQUEST"=>$this->getIdRequest()
                                        ]));

    }

    public function openNewRequest() {

        $sql = new Sql();

        $idRequest = $sql->query("INSERT INTO tbRequests(idOrder, desNote)
                    VALUES (:IDORDER, :DESNOTE)", [
                        ":IDORDER"=>$this->getIdOrder(),
                        ":DESNOTE"=>$this->getDesNote()
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
               // ":IDPRODUCT"=>$key,
                ":IDPRODUCT"=>$value["idProduct"],
                ":QTPRODUCT"=>$value["qtTotal"],
                ":VLUNITY"=>$value["vlUnity"]
            ]);

        }

        $data['message'] = 'Novo pedido adicionado';
        $this->pusher->trigger($this->getDesChannel(), 'new-request', $data);

        $cart->clearCart();

    }

    public function orderDataList() {

        $sql = new Sql();

        $arr = [];

        $requests = $sql->select("SELECT *, (
                                SELECT SUM(vlUnity*qtProduct) 
                                FROM tbRequestsProducts 
                                WHERE 
                                idRequest = a.idRequest
                            ) as vlTotal 
                     FROM tbRequests a 
                     WHERE isDeleted = :ISDELETED AND 
                     idOrder = :IDORDER
                     ORDER BY dtRegister ASC;", [
                        ":ISDELETED" => 0,
                        ":IDORDER" => $this->getIdOrder()
                     ]);

        foreach ($requests as $key) {

            $products = $sql->select("SELECT a.idProduct, a.qtProduct, a.vlUnity, b.desName, a.dtRegister 
                                      FROM tbRequestsProducts a 
                                      INNER JOIN tbProducts b 
                                      ON(a.idProduct = b.idProduct) 
                                      WHERE a.idRequest = :IDREQUEST", [
                            ":IDREQUEST" => $key["idRequest"]
                        ]);

            array_push($arr, [
                "idRequest" => $key["idRequest"],
                "desNote" => $key["desNote"],
                "vlTotal" => $key["vlTotal"],
                "vlStatus" => $key["vlStatus"],
                "listProducts" => $products,
                "dtRegister" => $key["dtRegister"]
            ]);
        }

        return json_encode($arr);

    }

    public function listRequestsByOrders(){

        $sql = new Sql();

		return json_encode($sql->select("
        SELECT *, (
                    SELECT SUM(vlUnity*qtProduct) 
                    FROM tbRequestsProducts 
                    WHERE 
                    idRequest = a.idRequest
                   ) as total 
        FROM tbRequests a 
        WHERE isDeleted = :ISDELETED AND 
        idOrder = :IDORDER
        ORDER BY dtRegister ASC
        ", [
				":ISDELETED" => 0,
                ":IDORDER" => $this->getIdOrder()
			]));

    }
    
    public function listProductsInRequest(){

        $sql = new Sql();

        return json_encode($sql->select("
            SELECT a.idRequestProduct, a.idRequest, a.idProduct, a.qtProduct, a.vlUnity, a.dtRegister, b.idProduct, b.desName 
            FROM tbRequestsProducts a 
            INNER JOIN tbProducts b 
            ON(a.idProduct = b.idProduct) 
            WHERE a.idRequest = :IDREQUEST", [
                ":IDREQUEST" => $this->getIdRequest()
            ]));

    }        

                   
    public function aproveRequest() {

        $sql = new Sql();

        $sql->query("UPDATE tbRequests
                                  SET
                                  vlStatus = :VLSTATUS
                                  WHERE
                                  idRequest = :IDREQUEST", [
                        ":IDREQUEST"=>$this->getIdRequest(),
                        ":VLSTATUS"=>$this->getVlStatus()
                    ]);

        return json_encode([
            'error' => false
        ]);

    }

}

?>