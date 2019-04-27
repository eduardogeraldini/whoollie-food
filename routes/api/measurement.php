<?php

use \WHOOLLIEFOOD\MODEL\User;
use \WHOOLLIEFOOD\MODEL\Device;
use \WHOOLLIEFOOD\MODEL\Measurement;

$app->get('/api/measurements', function($request, $response, $args) {
    
    if (!Device::verifyLogin()["login"]) {
		User::verifyLogin();
	}

    $measurements = new Measurement();
    echo $measurements->listAllMeasurements();
	
});

?>