<?php

use \WHOOLLIEFOOD\MODEL\User;
use \WHOOLLIEFOOD\MODEL\Employee;

$app->get('/ingredientes', function($request, $response, $args) {

	User::verifyLogin(false);

	if(Employee::verifyPrivileges("ingredients")){
        renderPage("ingredient", "listIngredients", false, "ingredient");
    } else {
        renderPage("errors", "errorPrivileges", false);
    }
	
});

?>