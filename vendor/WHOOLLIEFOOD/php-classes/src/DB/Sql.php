<?php 

namespace WHOOLLIEFOOD\DB;

class Sql {

	private $HOSTNAME = "";
	private $USERNAME = "";
	private $PASSWORD = "";
	private $DBNAME = "";

	private $conn;

	public function __construct()
	{

		if($_SERVER['REMOTE_ADDR'] == "::1") { 			
			$this->HOSTNAME = "localhost"; 			
			$this->USERNAME = "root"; 			
			$this->PASSWORD = ""; 			
			$this->DBNAME = "u672842222_food"; 		
		} else {	 			
			$this->HOSTNAME = "185.201.11.24"; 			
			$this->USERNAME = "u672842222_dev"; 			
			$this->PASSWORD = "whoollie123"; 			
			$this->DBNAME = "u672842222_food"; 		
		}

		$this->conn = new \PDO(
			"mysql:dbname=".$this->DBNAME.";host=".$this->HOSTNAME, 
			$this->USERNAME,
			$this->PASSWORD
		);

	}

	private function setParams($statement, $parameters = array())
	{

		foreach ($parameters as $key => $value) {
			
			$this->bindParam($statement, $key, $value);

		}

	}

	private function bindParam($statement, $key, $value)
	{

		$statement->bindParam($key, $value);

	}

	public function query($rawQuery, $params = array())
	{

		$stmt = $this->conn->prepare($rawQuery);

		$this->setParams($stmt, $params);

		$stmt->execute();

		return $this->conn->lastInsertId();

	}

	public function select($rawQuery, $params = array()):array
	{

		$stmt = $this->conn->prepare($rawQuery);

		$this->setParams($stmt, $params);

		$stmt->execute();

		return $stmt->fetchAll(\PDO::FETCH_ASSOC);

	}

}

 ?>