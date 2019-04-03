<?php 

use \WHOOLLIEFOOD\MODEL\Company;
use \WHOOLLIEFOOD\MODEL\User;

$app->post('/api/configs/company', function($request, $response, $args) {

    User::verifyLogin();
    
    $input = $request->getParsedBody();
    
    $company = new Company();
    
    $company->setDesName($input['desName']);
    $company->setDesCNPJ($input['desCNPJ']);

    $company->editCompany();
	
});

$app->get('/api/configs/company', function($request, $response, $args) {

    User::verifyLogin();

    $company = new Company();

    echo $company->listCurrentCompany();
	
});


?>