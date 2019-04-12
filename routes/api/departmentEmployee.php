<?php 

use \WHOOLLIEFOOD\MODEL\DepartmentEmployee;
use \WHOOLLIEFOOD\MODEL\User;

$app->post('/api/departments/employees/update/{id}', function($request, $response, $args) {

	User::verifyLogin();
    $input = $request->getParsedBody();

	$dept = new DepartmentEmployee();

	$dept->setDesName($input['desName']); 
	$dept->setIsActive($input['isActive']);

	$dept->updateDepartmentEmployee($args['id']);
	
});

$app->post('/api/departments/employees/delete/{id}', function($request, $response, $args) {

	User::verifyLogin();

	$dept = new DepartmentEmployee();
	 
	$dept->deleteDepartmentEmployee($args['id']);
	
});

$app->get('/api/departments/employees/{id}', function($request, $response, $args) {

	User::verifyLogin();

	$department = new DepartmentEmployee();

	echo $department->returnDepartmentById($args['id']);
	
});

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
	$department->setIsActive($input['isActive']);

	$department->createDepartmentEmployee();
	
});

?>