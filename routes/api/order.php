<?php 

use \WHOOLLIEFOOD\MODEL\User;
use \WHOOLLIEFOOD\MODEL\Cart;
use \WHOOLLIEFOOD\MODEL\Order;

$app->post('/api/opened/order', function($request, $response, $args) {

	User::verifyLogin();
    
    $order = new Order();
    echo json_encode($order->openedOrder());
    
});

$app->post('/api/open/order', function($request, $response, $args) {

	User::verifyLogin();

    $input = $request->getParsedBody();

    $order = new Order();

	$order->setDesName($input['desName']);
	$order->setIdBoard($input['idBoard']);    

    echo $order->openNewOrder();
    
});

$app->post('/api/close/order/{id}', function($request, $response, $args) {

	User::verifyLogin();

    $order = new Order();

    $order->setVlStatus(2);
	$order->setIdOrder($args['id']);    

    $order->closeOrder();

    $cart = new Cart();
    $cart->clearCart();
    
});

?>