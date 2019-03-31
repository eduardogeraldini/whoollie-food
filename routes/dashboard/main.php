<?php

use \WHOOLLIEFOOD\MODEL\User;

$app->get('/inicio', function($request, $response, $args) {

	User::verifyLogin(false);

	renderPage("", "principal");
	
});

?>