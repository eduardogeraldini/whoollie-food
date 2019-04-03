<?php 

use \WHOOLLIEFOOD\MODEL\User;

$app->get('/categorias/produtos', function($request, $response, $args) {
    
    User::verifyLogin(false);

	renderPage("product/categories", "listCategoriesProducts", false, "categoryProduct");
	
});

?>