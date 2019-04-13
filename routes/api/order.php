<?php 

use \WHOOLLIEFOOD\MODEL\User;
use \WHOOLLIEFOOD\MODEL\Order;

$app->post('/api/order/isOpen', function($request, $response, $args) {

	User::verifyLogin();
    
    $order = new Order();
    echo json_encode($order->orderIsOpen());
    
});

$app->post('/api/order/open', function($request, $response, $args) {

	User::verifyLogin();

    $input = $request->getParsedBody();

    $order = new Order();

	$order->setDesName($input['desName']);
	$order->setIdBoard($input['idBoard']);    

    $order->openNewOrder();
    
});

?>