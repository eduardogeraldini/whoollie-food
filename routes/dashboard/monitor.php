<?php 

use \WHOOLLIEFOOD\MODEL\User;

$app->get('/monitor', function ($request, $response, $args) {
	
	User::verifyLogin(false,false);
	renderPage("monitor", "monitor", true, "monitor");

});

?>