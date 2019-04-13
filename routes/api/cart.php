<?php 

use \WHOOLLIEFOOD\MODEL\User;
use \WHOOLLIEFOOD\MODEL\Cart;

$app->get('/api/cart', function($request, $response, $args) {

	User::verifyLogin();
    
    $cart = new Cart();
    echo json_encode($cart->getProducts());
    
});

$app->post('/api/cart/add/{idProduct}', function($request, $response, $args) {

	User::verifyLogin();
    
    $cart = new Cart();
    $cart->addProductToCart($args['idProduct']);
	
});

$app->post('/api/cart/remove/{idProduct}', function($request, $response, $args) {

	User::verifyLogin();
    
    $cart = new Cart();
    $cart->removeProductCart($args['idProduct']);
	
});

$app->post('/api/cart/remove/all/{idProduct}', function($request, $response, $args) {

	User::verifyLogin();
    
    $cart = new Cart();
    $cart->removeAllProductsCart($args['idProduct']);
	
});

?>