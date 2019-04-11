<?php

use \WHOOLLIEFOOD\MODEL\Employee;
use \WHOOLLIEFOOD\MODEL\User;

$app->post('/api/employees/update/{id}', function($request, $response, $args) {

	User::verifyLogin();
    $input = $request->getParsedBody();

	$employee = new Employee();

	$employee->setDesName($input['desName']);
	$employee->setDesCPF($input['desCPF']);
	$employee->setDtBirth($input['dtBirth']);
	$employee->setIsActive($input['isActive']);
    $employee->setIdDepartment($input['idDepartment']);   

	$employee->editEmployee($args['id']);
	
});

$app->post('/api/employees/delete/{id}', function($request, $response, $args) {

	User::verifyLogin();

	$employee = new Employee();
	$employee->setIsDeleted(1);  
	$employee->deleteEmployee($args['id']);
	
});


$app->post('/api/privileges/employees', function($request, $response, $args) {

	User::verifyLogin();
    $input = $request->getParsedBody();
	
	$employee = new Employee();
	$employee->securePrivileges($input['idEmployee'], $input['column'], $input['value']);
	
});

$app->get('/api/employees/{id}', function($request, $response, $args) {

	User::verifyLogin();

	$employee = new Employee();
	echo $employee->listEmployeeById($args['id']);
	
});



$app->post('/api/employees', function($request, $response, $args) {

	User::verifyLogin();
    $input = $request->getParsedBody();
    
    $idUser = User::createUser($input['desLogin'],$input['desPassword']);
    $employee = new Employee();

	$employee->setDesName($input['desName']);
	$employee->setDesCPF($input['desCPF']);
	$employee->setDtBirth($input['dtBirth']);
	$employee->setIsActive($input['isActive']);
    $employee->setIdDepartment($input['idDepartment']);
    $employee->setIdUser($idUser);    

	$employee->createEmployee();
	
});


$app->get('/api/employees', function($request, $response, $args) {

	User::verifyLogin();

    $employee = new Employee(); 

	echo $employee->listAll();
	
});

$app->get('/api/currentEmployee', function($request, $response, $args) {

	User::verifyLogin();

	$employee = new Employee(); 

	echo $employee->listCurrentEmployee();
	
});


?>