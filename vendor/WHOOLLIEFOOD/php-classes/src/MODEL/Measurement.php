<?php

namespace WHOOLLIEFOOD\MODEL;

use \WHOOLLIEFOOD\DB\Sql;

class Measurement {

    private $idMeasurement;
	private $desName;
	private $desShort;

	public function getIdMeasurement() {
		return $this->idMeasurement;
	}

	public function setIdMeasurement($idMeasurement) {
		$this->idMeasurement = $idMeasurement;
	}

	public function getDesName() {
		return $this->desName;
	}

	public function setDesName($desName) {
		$this->desName = $desName;
	}

	public function getDesShort() {
		return $this->desShort;
	}

	public function setDesShort($desShort) {
		$this->desShort = $desShort;
    }
    
    public function listAllMeasurements() {

        $sql = new Sql();

        return json_encode($sql->select("SELECT *
                            FROM tbMeasurements
                            ORDER BY desName"));

    }

}

?>