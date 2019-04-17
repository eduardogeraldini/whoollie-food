<?php

use \WHOOLLIEFOOD\MODEL\User;
use \WHOOLLIEFOOD\MODEL\Device;

$app->post('/api/devices', function($request, $response, $args) {
    
    User::verifyLogin();
    
    $input = $request->getParsedBody();
	
    $device = new Device();
    
    $device->setDesName($input["desName"]);
	$device->setDesLogin($input["desLogin"]);
	$device->setDesPassword($input["desPassword"]);

    $device->createDevice();
	
});


$app->get('/api/devices', function($request, $response, $args) {
    
    User::verifyLogin();

    echo $device->listAllDevices();
	
});

?>