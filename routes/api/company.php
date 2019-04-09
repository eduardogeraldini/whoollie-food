<?php 

use \WHOOLLIEFOOD\MODEL\User;
use \WHOOLLIEFOOD\MODEL\Company;

$app->get('/api/currentCompany', function($request, $response, $args) {

	User::verifyLogin();

	$company = new Company();

	echo $company->listCurrentCompany();
	
});

?>