<?php

use \WHOOLLIEFOOD\MODEL\Employee;
use \WHOOLLIEFOOD\MODEL\User;

$app->post('/api/employees', function($request, $response, $args) {

	User::verifyLogin();
    $input = $request->getParsedBody();
    
    User::createUser($input['desLogin'],$input['desPassword']);
    $idUser = User::returnLastUser();

    $employee = new Employee();

	$employee->setDesName($input['desName']);
	$employee->setDesCPF($input['desCPF']);
	$employee->setDtBirth($input['dtBirth']);
	$employee->setIsActive($input['isActive']);
    $employee->setIdDepartment($input['idDepartment']);
    $employee->setIdLogin($idUser);    

	$employee->createEmployeer();
	
});


$app->get('/api/employees', function($request, $response, $args) {

	User::verifyLogin();

    $employee = new Employee(); 

	echo $employee->listAll();
	
});


?>