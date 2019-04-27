<?php

use \WHOOLLIEFOOD\MODEL\User;
use \WHOOLLIEFOOD\MODEL\Employee;

$app->get('/relatorios', function($request, $response, $args) {

	User::verifyLogin(false);

	if(Employee::verifyPrivileges("reports")){
        renderPage("reports", "reports", false);
    } else {
        renderPage("errors", "errorPrivileges", false);
    }
	
});