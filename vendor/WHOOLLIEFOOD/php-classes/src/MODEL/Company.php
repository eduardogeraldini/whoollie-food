<?php

namespace WHOOLLIEFOOD\MODEL;

use \WHOOLLIEFOOD\DB\Sql;

class Company{

    private $idCompany;
	private $desName;
	private $desCNPJ;

	public function __construct(){

		$this->idCompany = $_SESSION['User']['idCompany'];

	}

	public function setDesName($desName){
		$this->desName = $desName;
	}

	public function setDesCNPJ($desCNPJ){
		$this->desCNPJ = $desCNPJ;
	}

	public function getDesName(){
		return $this->desName;
	}

	public function getDesCNPJ(){
		return $this->desCNPJ;
    }
    
    public function getIdCompany(){
		return $this->idCompany;
	}

	public function listCurrentCompany(){

		$sql = new Sql();

		return json_encode($sql->select("SELECT * FROM tbCompanies WHERE idCompany = :IDCOMPANY", [
            ":IDCOMPANY" => $this->getIdCompany()
        ]));

    }

    public function editCompany(){

        $sql = new Sql();

        if($this->getDesName() != "" && $this->getDesCNPJ() != ""){

            return $sql->query("UPDATE tbCompanies SET desName = :DESNAME, desCNPJ = :DESCNPJ WHERE idCompany = :IDCOMPANY", [
               ":DESNAME" => $this->getDesName(),
               ":DESCNPJ" => $this->getDesCNPJ(),
               ":IDCOMPANY" => $this->getIdCompany()
            ]);
              
        } 

	}

}

?>