<?php 

use \WHOOLLIEFOOD\MODEL\DepartmentEmployee;
use \WHOOLLIEFOOD\MODEL\User;

$app->get('/api/departments/employees', function($request, $response, $args) {

	User::verifyLogin();

	$department = new DepartmentEmployee();

	echo $department->listAll();
	
});


$app->post('/api/departments/employees', function($request, $response, $args) {

	User::verifyLogin();

	$input =  $request->getParsedBody();

	$department = new DepartmentEmployee();

	$department->setDesName($input['desName']);

	$department->createDepartmentEmployee();
	
});

?>