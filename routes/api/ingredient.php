<?php

use \WHOOLLIEFOOD\MODEL\Ingredient;
use \WHOOLLIEFOOD\MODEL\User;
use \WHOOLLIEFOOD\MODEL\Device;

$app->post('/api/remove/ingredient/product', function($request, $response, $args) {
	
	User::verifyLogin();

	$input = $request->getParsedBody();

	$ingredient = new Ingredient();
	$ingredient->setIdIngredientProduct($input["idIngredientProduct"]);  
	echo $ingredient->removeIngredientByProduct();
	
});

$app->post('/api/add/ingredient/product', function($request, $response, $args) {
	
	User::verifyLogin();

	$input = $request->getParsedBody();

	$ingredient = new Ingredient();
	$ingredient->setIdIngredient($input["idIngredient"]);  
	$ingredient->setIdProduct($input["idProduct"]);  
	$ingredient->setQtIngredient($input["qtIngredient"]);  
	$ingredient->setIdMeasurement($input["idMeasurement"]);  
	echo $ingredient->addIngredientToProduct();
	
});

$app->get('/api/related/ingredients/product/{id}', function($request, $response, $args) {

	if (!Device::verifyLogin()["login"]) {
		User::verifyLogin();
	}

    $ingredient = new Ingredient();
	$ingredient->setIdProduct($args["id"]);
	$ingredient->setIsDeleted(0);

	echo $ingredient->getRelatedIngredientsByProduct();
	
});


$app->get('/api/unrelated/ingredients/product/{id}', function($request, $response, $args) {

	if (!Device::verifyLogin()["login"]) {
		User::verifyLogin();
	}

    $ingredient = new Ingredient();
	$ingredient->setIdProduct($args["id"]);
	$ingredient->setIsDeleted(0);

	echo $ingredient->getUnrelatedIngredientsByProduct();
	
});

$app->post('/api/ingredient/delete/{id}', function($request, $response, $args) {
	
	User::verifyLogin();

	$ingredient = new Ingredient();
	$ingredient->setIdIngredient($args['id']);  
	$ingredient->setIsDeleted(1);  
	$ingredient->deleteIngredient();
	
});

$app->post('/api/ingredient/update/{id}', function($request, $response, $args) {
	
	User::verifyLogin();

	$input = $request->getParsedBody();

	$ingredient = new Ingredient();

    $ingredient->setIdIngredient($args['id']);
	$ingredient->setDesName($input['desName']);
	$ingredient->setVlUnity($input['vlUnity']);
	$ingredient->setIsActive($input['isActive']);

	echo $ingredient->editIngredient();
	
});

$app->get('/api/ingredient/{id}', function($request, $response, $args) {

	if (!Device::verifyLogin()["login"]) {
		User::verifyLogin();
	}

    $ingredient = new Ingredient();

    $ingredient->setIdIngredient($args['id']);

	echo $ingredient->listIngredientById();
	
});

$app->post('/api/ingredients', function($request, $response, $args) {

	User::verifyLogin();
	$input = $request->getParsedBody();

	$ingredient = new Ingredient();

	$ingredient->setDesName($input['desName']);
	$ingredient->setVlUnity($input['vlUnity']);
	$ingredient->setIsActive($input['isActive']);

	echo $ingredient->createIngredient();
	
});

$app->get('/api/ingredients', function($request, $response, $args) {

	if (!Device::verifyLogin()["login"]) {
		User::verifyLogin();
	}

    $ingredient = new Ingredient();
    
    $ingredient->setIsDeleted(0);

	echo $ingredient->listAll();
	
});

?>