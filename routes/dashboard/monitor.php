<?php 

use \WHOOLLIEFOOD\MODEL\User;
use \WHOOLLIEFOOD\MODEL\Employee;

$app->get('/monitor', function ($request, $response, $args) {
	
	User::verifyLogin(false,false);
	
	if(Employee::verifyPrivileges("monitor")){
        renderPage("monitor", "monitor", true, "monitor");
    } else {
        renderPage("errors", "errorPrivileges", false);
    }

});

?>