<?php 

use \WHOOLLIEFOOD\MODEL\User;
use \WHOOLLIEFOOD\MODEL\Employee;

$app->get('/cardapio-digital', function($request, $response, $args) {

    User::verifyLogin(false);
    
    if(Employee::verifyPrivileges("products")){
        renderPage("digitalMenu", "digitalMenu", false, "digitalMenu");
    } else {
        renderPage("errors", "errorPrivileges", false);
    }
	
});

?>