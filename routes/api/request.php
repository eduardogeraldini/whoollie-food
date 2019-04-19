<?php 

use \WHOOLLIEFOOD\MODEL\User;
use \WHOOLLIEFOOD\MODEL\Request;

$app->get('/api/products/request/{id}', function($request, $response, $args) {

	User::verifyLogin();
    
    $request = new Request();

    $request->setIdRequest($args["id"]);

    echo $request->listProductsByRequest();
    
});

$app->get('/api/requests', function($request, $response, $args) {

	User::verifyLogin();
    
    $request = new Request();

    $request->setVlStatus(0);

    echo $request->listAll();
    
});

$app->post('/api/request', function($request, $response, $args) {

	User::verifyLogin();
    
    $request = new Request();
    $request->openNewRequest();
    
});

?>