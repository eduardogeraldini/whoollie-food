<?php

use \WHOOLLIEFOOD\MODEL\User;

$app->get('/funcionarios', function($request, $response, $args) {

	User::verifyLogin(false);

	renderPage("employee", "employee", false, "employee");
	
});

?>