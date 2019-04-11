<?php 

use \WHOOLLIEFOOD\MODEL\User;
use \WHOOLLIEFOOD\MODEL\Employee;

$app->get('/departamentos/funcionarios', function($request, $response, $args) {
    
    User::verifyLogin(false);
    
    if(Employee::verifyPrivileges("employees")){
        renderPage("employee/departments", "listDepartments", false, "departmentEmployee");
    } else {
        renderPage("errors", "errorPrivileges", false);
    }
	
});

?>