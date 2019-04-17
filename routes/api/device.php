<?php

use \WHOOLLIEFOOD\MODEL\User;
use \WHOOLLIEFOOD\MODEL\Device;

$app->post('/api/device/edit/{id}', function($request, $response, $args) {
    
    User::verifyLogin();

    $input = $request->getParsedBody();
	
    $device = new Device();
    
    $device->setIdDevice($args["id"]);
    $device->setDesName($input["desName"]);
	$device->setDesLogin($input["desLogin"]);
	$device->setDesPassword($input["desPassword"]);

    echo $device->editDevice();

});

$app->get('/api/device/{id}', function($request, $response, $args) {
    
    User::verifyLogin();

    $device = new Device();
    $device->setIdDevice($args["id"]);

    echo $device->listDeviceById();

});


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

    $device = new Device();
    echo $device->listAllDevices();
	
});

?>