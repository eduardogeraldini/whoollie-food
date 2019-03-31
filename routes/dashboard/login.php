<?php 

use \WHOOLLIEFOOD\MODEL\User;

$app->get('/', function ($request, $response, $args) {
	
	header("Location: /entrar");
	exit;

});

$app->get('/entrar', function ($request, $response, $args) {
	
	User::verifyLogin(false, true);
	renderPage("", "login", true, "login");

});

?>