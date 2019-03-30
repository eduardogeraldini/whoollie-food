<?php 

use \WHOOLLIEFOOD\MODEL\ProductCategory;
use \WHOOLLIEFOOD\MODEL\User;

$app->get('/api/categories/products', function($request, $response, $args) {

	User::verifyLogin();

	$category = new ProductCategory();

	echo $category->listAll();
	
});


$app->post('/api/categories/products', function($request, $response, $args) {

	User::verifyLogin();

	$input =  $request->getParsedBody();

	$category = new ProductCategory();

	$category->setDesName($input['desName']);

	$category->createProductCategory();
	
});

?>