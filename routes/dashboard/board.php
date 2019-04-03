<?php

use \WHOOLLIEFOOD\MODEL\User;

$app->get('/comandas', function($request, $response, $args) {

	User::verifyLogin(false);

	renderPage("boards", "boards", false);
	
});

?>