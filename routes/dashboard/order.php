<?php

use \WHOOLLIEFOOD\MODEL\User;
use \WHOOLLIEFOOD\MODEL\Employee;

$app->get('/comandas', function($request, $response, $args) {

	User::verifyLogin(false);

	if(Employee::verifyPrivileges("orders")){
        renderPage("orders", "orders", false, "order");
    } else {
        renderPage("errors", "errorPrivileges", false);
    }
	
	
});

?>