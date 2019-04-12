<?php

use \WHOOLLIEFOOD\MODEL\Product;
use \WHOOLLIEFOOD\MODEL\User;

$app->post('/api/product/delete/{id}', function($request, $response, $args) {
	
	User::verifyLogin();

	$product = new Product();
	$product->setIsDeleted(1);  
	$product->deleteProduct($args['id']);
	
});

$app->post('/api/product/update/{id}', function($request, $response, $args) {
	
	User::verifyLogin();

	$input = $request->getParsedBody();

	$product = new Product();

	$product->setDesName($input['desName']);
	$product->setDesNote($input['desNote']);
	$product->setVlUnity($input['vlUnity']);
	$product->setIsActive($input['isActive']);
	$product->setIdProductCategory($input['idProductCategory']);
	$product->setDesImagePath($_FILES, $input['desOldImagePath']);

	$product->editProduct($args['id']);
	
});

$app->post('/api/filter/products', function($request, $response, $args) {

	User::verifyLogin();

	$input = $request->getParsedBody();

	$product = new Product();

	echo $product->listFilterProducts($input);
	
});

$app->get('/api/products/{id}', function($request, $response, $args) {

	User::verifyLogin();

	echo Product::listProductById($args['id']);
	
});

$app->post('/api/products', function($request, $response, $args) {

	User::verifyLogin();
	$input = $request->getParsedBody();

	$product = new Product();

	$product->setDesName($input['desName']);
	$product->setDesNote($input['desNote']);
	$product->setVlUnity($input['vlUnity']);
	$product->setIsActive($input['isActive']);
	$product->setIdProductCategory($input['idProductCategory']);
	$product->setDesImagePath($_FILES);

	$product->createProduct();
	
});

$app->get('/api/products', function($request, $response, $args) {

	User::verifyLogin();

	$product = new Product();

	echo $product->listAll();
	
});

?>