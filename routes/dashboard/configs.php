<?php 

use \WHOOLLIEFOOD\MODEL\User;

$app->get('/configs/company', function($request, $response, $args) {
    
    User::verifyLogin(false);

	renderPage("configs", "company", false, "configs");
	
});


?>