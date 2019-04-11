<?php 

use \WHOOLLIEFOOD\MODEL\User;
use \WHOOLLIEFOOD\MODEL\Employee;

$app->get('/configs/company', function($request, $response, $args) {
    
    User::verifyLogin(false);

    if(Employee::verifyPrivileges("configs")){
        renderPage("configs", "company", false, "configs");
    } else {
        renderPage("errors", "errorPrivileges", false);
    }

	
});


?>