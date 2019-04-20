<?php 

use \WHOOLLIEFOOD\MODEL\User;
use \WHOOLLIEFOOD\MODEL\Request;

$app->post('/api/request', function($request, $response, $args) {

	User::verifyLogin();
    
    $request = new Request();
    $request->openNewRequest();
    
});

$app->get('/api/requests/orders/{id}', function($request, $response, $args) {

	User::verifyLogin();
    
    $request = new Request();

    $request->setIdOrder($args['id']);
    
	echo $request->listRequestsByOrders();
    
});

$app->get('/api/requests/products/{id}', function($request, $response, $args) {

	User::verifyLogin();
    
    $request = new Request();

    $request->setIdRequest($args['id']);
    
	echo $request->listProductsInRequest();
    
});

?>