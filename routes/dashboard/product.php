<?php

use \WHOOLLIEFOOD\MODEL\User;
use \WHOOLLIEFOOD\MODEL\Employee;

$app->get('/produtos', function($request, $response, $args) {

	User::verifyLogin(false);

	if(Employee::verifyPrivileges("products")){
        renderPage("product", "listProduct", false, "product");
    } else {
        renderPage("errors", "errorPrivileges", false);
    }
	
});

?>