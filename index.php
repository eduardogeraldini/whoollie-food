<?php 

session_start();

require_once("vendor/autoload.php");
require_once("functions.php");

use \WHOOLLIEFOOD\MODEL\Product;
use \WHOOLLIEFOOD\MODEL\User;

$app = new \Slim\App();

$app->get('/api', function ($request, $response, $args) {
	$response->getBody()->write(' Hello ');

	return $response;
});

$app->get('/login', function ($request, $response, $args) {
	
	renderPage("", "login", true);

});

$app->post('/api/login', function ($request, $response, $args) {
	
		$login = $request->getParam('desLogin');
		$senha = $request->getParam('desPassword');

		echo User::login($login, $senha);

});

$app->get('/api/logout', function ($request, $response, $args) {

	User::verifyLogin();
	User::logout();

});

$app->get('/api/produtos', function($request, $response, $args) {

	User::verifyLogin();

	$product = new Product();

	echo $product->listAll();
	
});

$app->get('/produtos', function($request, $response, $args) {

	User::verifyLogin(false);

	renderPage("product", "criarProdutos");
	
});

$app->post('/api/produtos', function($request, $response, $args) {

	User::verifyLogin();
	$input = $request->getParsedBody();

	$product = new Product();

	$product->setDesName($input['desName']);
	$product->setDesNote($input['desNote']);
	$product->setVlUnity($input['vlUnity']);
	$product->setQtStock($input['qtStock']);
	$product->setIdProductCategory($input['idProductCategory']);

	$product->createProduct();
	
});

$app->get('/api/produtos/{id}', function($request, $response, $args) {

	User::verifyLogin();

	echo Product::listProductById($args['id']);
	
});

$app->run();

 ?>