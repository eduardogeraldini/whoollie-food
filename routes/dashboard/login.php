<?php 

use \WHOOLLIEFOOD\MODEL\User;

$app->get('/logar', function ($request, $response, $args) {
	
	User::verifyLogin(false, true);
	renderPage("", "login", true, "login");

});

?>