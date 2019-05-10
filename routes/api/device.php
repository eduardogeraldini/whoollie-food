<?php

use \WHOOLLIEFOOD\MODEL\User;
use \WHOOLLIEFOOD\MODEL\Device;

$app->get('/api/verify/login/device', function ($request, $response, $args) {
    echo json_encode(Device::verifyLogin()["login"]);
});

$app->post('/api/device/delete/{id}', function($request, $response, $args) {
    
    User::verifyLogin();

    $device = new Device();

    $device->setIdDevice($args["id"]);
    $device->setIsDeleted(1);

    echo $device->deleteDevice();

});

$app->post('/api/device/edit/{id}', function($request, $response, $args) {
    
    User::verifyLogin();

    $input = $request->getParsedBody();
	
    $device = new Device();
    
    $device->setIdDevice($args["id"]);
    $device->setDesName($input["desName"]);
	$device->setDesLogin($input["desLogin"]);
    $device->setDesPassword($input["desPassword"]);
    $device->setIsActive($input["isActive"]);
    $device->setIdBoard($input["idBoard"]);

    echo $device->editDevice();

});

$app->post('/api/device/login', function ($request, $response, $args) {

    $device = new Device();
    
    $device->setDesLogin($request->getParam('desLogin'));
    $device->setDesPassword($request->getParam('desPassword'));
    $device->setIsDeleted(0);
	$device->setIsActive(1);
    
    echo $device->login();

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
    $device->setIsActive($input["isActive"]);
    $device->setIdBoard($input["idBoard"]);

    $device->createDevice();
	
});


$app->get('/api/devices', function($request, $response, $args) {
    
    User::verifyLogin();

    $device = new Device();
    $device->setIsDeleted(0);
    echo $device->listAllDevices();
	
});

?>