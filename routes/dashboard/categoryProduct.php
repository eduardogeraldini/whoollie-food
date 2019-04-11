<?php 

use \WHOOLLIEFOOD\MODEL\User;
use \WHOOLLIEFOOD\MODEL\Employee;

$app->get('/categorias/produtos', function($request, $response, $args) {
    
    User::verifyLogin(false);
    
    if(Employee::verifyPrivileges("products")){
        renderPage("product/categories", "listCategoriesProducts", false, "categoryProduct");
    } else {
        renderPage("errors", "errorPrivileges", false);
    }
	
});

?>