<?php

use \WHOOLLIEFOOD\MODEL\User;

$app->get('/dashboard', function($request, $response, $args) {

	User::verifyLogin(false);

	renderPage("", "principal");
	
});

?>