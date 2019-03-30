<?php 

session_start();

require_once("vendor/autoload.php");

use \WHOOLLIEFOOD\MODEL\Product;
use \WHOOLLIEFOOD\MODEL\User;

$app = new \Slim\App();

$app->get('/', function ($request, $response, $args) {
	$response->getBody()->write(' Hello ');

	return $response;
});

$app->post('/login', function ($request, $response, $args) {
	
		$login = $request->getParam('login');
		$senha = $request->getParam('senha');

		echo User::login($login, $senha);

});

$app->post('/logout', function ($request, $response, $args) {

	User::verifyLogin();
	
	$login = $request->getParam('login');
	$senha = $request->getParam('senha');

	echo User::login($login, $senha);

});


$app->get('/produtos', function($request, $response, $args) {

	User::verifyLogin();

	$product = new Product();

	echo $product->listAll();
	
});

$app->post('/produtos', function($request, $response, $args) {

	User::verifyLogin();
	$input = $request->getParsedBody();

	$product = new Product();

	$product->setDesName($input['desName']);
	$product->setDesNote($input['desNote']);
	$product->setVlUnity($input['vlUnity']);
	$product->setQtStock($input['qtStock']);

	$product->createProduct($input);
	
});

$app->get('/produtos/{id}', function($request, $response, $args) {

	User::verifyLogin();

	echo Product::listProductById($args['id']);
	
});

$app->run();

 ?>