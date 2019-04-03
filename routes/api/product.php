<?php

use \WHOOLLIEFOOD\MODEL\Product;
use \WHOOLLIEFOOD\MODEL\User;

$app->get('/api/products/{id}', function($request, $response, $args) {

	User::verifyLogin();

	echo Product::listProductById($args['id']);
	
});

$app->post('/api/products', function($request, $response, $args) {

	User::verifyLogin();
	$input = $request->getParsedBody();

	$product = new Product();

	var_dump($input['desName']);

	$product->setDesName($input['desName']);
	$product->setDesNote($input['desNote']);
	$product->setVlUnity($input['vlUnity']);
	$product->setQtStock($input['qtStock']);
	$product->setIdProductCategory($input['idProductCategory']);

	$product->createProduct();
	
});

$app->get('/api/products', function($request, $response, $args) {

	User::verifyLogin();

	$product = new Product();

	echo $product->listAll();
	
});

?>