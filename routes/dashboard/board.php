<?php 

use \WHOOLLIEFOOD\MODEL\User;
use \WHOOLLIEFOOD\MODEL\Employee;

$app->get('/mesas', function($request, $response, $args) {
    
    User::verifyLogin(false);
    
    if(Employee::verifyPrivileges("boards")){
        renderPage("boards", "listBoards", false, "board");
    } else {
        renderPage("errors", "errorPrivileges", false);
    }
	
});

?>