<?php 

use \WHOOLLIEFOOD\MODEL\User;

$app->get('/categorias/produtos', function($request, $response, $args) {
    
    User::verifyLogin(false);

	renderPage("product/categories", "listCategoriesProducts");
	
});


$app->get('/categorias/produtos/criar', function($request, $response, $args) {

	User::verifyLogin(false);

	renderPage("product/categories", "createCategoriesProducts", false, "categoryProduct");
	
});

?>