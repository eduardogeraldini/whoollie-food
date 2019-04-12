<?php 

use \WHOOLLIEFOOD\MODEL\ProductCategory;
use \WHOOLLIEFOOD\MODEL\User;

$app->post('/api/categories/products/update/{id}', function($request, $response, $args) {

	User::verifyLogin();
    $input = $request->getParsedBody();

	$category = new ProductCategory();

	$category->setDesName($input['desName']); 
	$category->setIsActive($input['isActive']);

	$category->updateProductCategory($args['id']);
	
});

$app->post('/api/categories/products/delete/{id}', function($request, $response, $args) {

	User::verifyLogin();

	$category = new ProductCategory();
	 
	$category->deleteProductCategory($args['id']);
	
});

$app->get('/api/categories/products/{id}', function($request, $response, $args) {

	User::verifyLogin();

	$category = new ProductCategory();

	echo $category->returnProductCategoryById($args['id']);
	
});

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
	$category->setIsActive($input['isActive']);

	$category->createProductCategory();
	
});

?>