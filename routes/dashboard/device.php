<?php 

use \WHOOLLIEFOOD\MODEL\User;
use \WHOOLLIEFOOD\MODEL\Employee;

$app->get('/dispositivos', function($request, $response, $args) {
    
    User::verifyLogin(false);
    
    if(Employee::verifyPrivileges("employees")){
        renderPage("device", "listDevices", false, "device");
    } else {
        renderPage("errors", "errorPrivileges", false);
    }
	
});

?>