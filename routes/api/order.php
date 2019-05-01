<?php 

use \WHOOLLIEFOOD\MODEL\User;
use \WHOOLLIEFOOD\MODEL\Cart;
use \WHOOLLIEFOOD\MODEL\Order;
use \WHOOLLIEFOOD\MODEL\Device;

$app->get('/api/orders/by/month', function($request, $response, $args) {
	
	User::verifyLogin();

	$order = new Order();
	
	echo $order->ordersByMonth();
	
});

/*$app->get('/api/price/order/{id}', function($request, $response, $args) {

	User::verifyLogin();

    $order = new Order();
    $order->setIdOrder($args['id']);
	echo $order->returnPriceByOrders();
	
});*/

//FECHAR COMANDAR POR ID
$app->post('/api/close/order/{id}', function($request, $response, $args) {

	User::verifyLogin();

    $order = new Order();

    $order->setVlStatus(1);
	$order->setIdOrder($args['id']);    

    echo $order->closeOrder();
    
});

$app->post('/api/opened/order', function($request, $response, $args) {

	if (!Device::verifyLogin()["login"]) {
		User::verifyLogin();
	}
    
    $order = new Order();
    echo json_encode($order->openedOrder());
    
});

$app->post('/api/open/order', function($request, $response, $args) {

	if (!Device::verifyLogin()["login"]) {
		User::verifyLogin();
    }

    $input = $request->getParsedBody();

    $order = new Order();

	$order->setDesName($input['desName']);
	//$order->setIdBoard($input['idBoard']);    
    
    echo $order->openNewOrder();
    
});


$app->post('/api/close/order', function($request, $response, $args) {

	if (!Device::verifyLogin()["login"]) {
		User::verifyLogin();
	}

    $order = new Order();

    $order->setVlStatus(1);
	$order->setIdOrder($_SESSION["Order"]["id"]);    

    echo $order->closeOrder();

    $cart = new Cart();
    $cart->clearCart();
    
});

$app->get('/api/orders/{id}', function($request, $response, $args) {

	User::verifyLogin();

    $order = new Order();
	echo $order->listOrderById($args['id']);
	
});

$app->get('/api/orders', function($request, $response, $args) {

    User::verifyLogin();
    
    $order = new Order();
	echo $order->listAll();
	
});

?>