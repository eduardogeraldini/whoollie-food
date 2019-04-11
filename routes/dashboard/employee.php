<?php

use \WHOOLLIEFOOD\MODEL\User;
use \WHOOLLIEFOOD\MODEL\Employee;

$app->get('/funcionarios', function($request, $response, $args) {

	User::verifyLogin(false);

	if(Employee::verifyPrivileges("employees")){
		renderPage("employee", "employee", false, "employee");
    } else {
        renderPage("errors", "errorPrivileges", false);
    }


	
});

?>