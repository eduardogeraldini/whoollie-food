<?php 

namespace WHOOLLIEFOOD\DB;

setlocale(LC_TIME, 'pt_BR', 'pt_BR.utf-8', 'pt_BR.utf-8', 'portuguese');
date_default_timezone_set('America/Sao_Paulo');

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
			$this->PASSWORD,
			[\PDO::ATTR_ERRMODE => \PDO::ERRMODE_EXCEPTION, \PDO::ATTR_PERSISTENT => true, \PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES 'utf8' COLLATE 'utf8_unicode_ci, SET time_zone = 'America/Sao_Paulo''"]
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