<?php

use \WHOOLLIEFOOD\MODEL\User;

$app->get('/produtos', function($request, $response, $args) {

	User::verifyLogin(false);

	renderPage("product", "listProduct", false, "createProduct");
	
});

$app->get('/produtos/criar', function($request, $response, $args) {

	User::verifyLogin(false);

	renderPage("product", "createProduct");
	
});


?>