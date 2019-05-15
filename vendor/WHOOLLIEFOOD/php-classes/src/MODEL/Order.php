<?php

namespace WHOOLLIEFOOD\MODEL;

use \WHOOLLIEFOOD\DB\Sql;
use \WHOOLLIEFOOD\MODEL\Product;
use \PUSHER\Pusher;

class Order {

	private $idCompany;
	private $idDevice;
	private $idOrder;
	private $idBoard;
	private $desName;
    private $vlDiscount;
    
    private $options;
	private $pusher;
	private $desChannel;
    
	public function __construct() {
        if(isset($_SESSION['Device'])){
            $this->idCompany = $_SESSION['Device']['idCompany'];
            $this->idDevice = $_SESSION['Device']['idDevice'];
            $this->idBoard = $_SESSION['Device']['idBoard'];
            $this->desChannel = $_SESSION["Device"]['desChannel'];
        } else {
            $this->idCompany = $_SESSION['User']['idCompany'];
            $this->desChannel = $_SESSION['User']['desChannel'];
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
        $this->idCompany = $idCompany;
    }

    public function getIdCompany() {
        return $this->idCompany;
    }

    public function setDesChannel($value) {
        $this->desChannel = $value;
    }

    public function getDesChannel() {
        return $this->desChannel;
    }

    public function setIdDevice($value) {
        $this->idDevice = $value;
    }

    public function getIdDevice() {
        return $this->idDevice;
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
                return [
                    "open" => true,
                    "id" => (int) $_SESSION["Order"]["id"]
                ];
            else
                return ["open" => false];
        } else { 
            return ["open" => false];
        }

    }

    public function clearOrder() {
        $this->setIdOrder("");
    }

    public function openNewOrder() {

        $sql = new Sql();

        $idOrder = $sql->query("INSERT INTO tbOrders(idCompany, idDevice, idBoard, desName)
                    VALUES (:IDCOMPANY, :IDDEVICE, :IDBOARD, :DESNAME)", [
                        ":IDCOMPANY"=>$this->getIdCompany(), 
                        ":IDDEVICE"=>$this->getIdDevice(), 
                        ":IDBOARD"=>$this->getIdBoard(), 
                        ":DESNAME"=>$this->getDesName()
                    ]);

        $this->setIdOrder($idOrder);

        $_SESSION["Order"]["desName"] = $this->getDesName();

        return json_encode([
            "idOrder"=>$this->getIdOrder(),
            "idBoard"=>$this->getIdBoard(),
            "desName"=>$this->getDesName(),
            "desChannel"=>$this->getDesChannel()
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

            $data['message'] = 'Comanda finalizada!';
            $this->pusher->trigger($this->getDesChannel(), 'close-order-id-'.$this->getIdOrder(), $data);

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
    
    public function ringBell() {

        $board = new Board();
        $vlBoard = json_decode($board->listBoardById((int) $_SESSION["Device"]["idBoard"]));

        $data['message'] = 'O cliente '.$_SESSION["Order"]["desName"].' da mesa ['.$vlBoard.'] está solicitando o atendimento !\n';
        $this->pusher->trigger($this->getDesChannel(), "ringbell", $data);

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
            SELECT a.idOrder, a.idCompany, a.desName, a.vlDiscount, a.vlStatus, a.dtRegister, 
                    (
                            SELECT SUM(rp.vlUnity * rp.qtProduct) 
                                FROM tbRequestsProducts rp
                                INNER JOIN tbRequests r ON (r.idRequest = rp.idRequest)
                                WHERE 
                                r.idOrder = a.idOrder
                    ) AS total 
            FROM tbOrders a 
            WHERE a.isDeleted = :ISDELETED
            AND a.idCompany = :IDCOMPANY
            ORDER BY a.dtRegister DESC", [
				":ISDELETED" => 0,
				":IDCOMPANY" => $this->getIdCompany()
			]));

    }
    
    public function ordersByMonth() {

		$sql = new Sql();

		$data = [];

		for ($month = 1; $month <= 12; $month++) { 
		
			$res = $sql->select("SELECT COUNT(DISTINCT r.idOrder) AS 'total'
				FROM tbRequests r
				INNER JOIN tbOrders o ON (r.idOrder = o.idOrder)
				WHERE
				YEAR(r.dtRegister) = :YEAR AND
				MONTH(r.dtRegister) = :MONTH AND
				o.idCompany = :IDCOMPANY;", [
					":YEAR"=>date("Y", strtotime("now")),                 
					":MONTH"=>$month,                  
					":IDCOMPANY"=>$this->getIdCompany()                  
			])[0];

			$data[] = [
                "month" => $month,
                "total" => $res["total"]
            ];
		
		}

		return json_encode($data);

	}

}

?>