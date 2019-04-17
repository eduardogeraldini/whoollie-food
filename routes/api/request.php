<?php 

use \WHOOLLIEFOOD\MODEL\User;
use \WHOOLLIEFOOD\MODEL\Request;

$app->post('/api/request', function($request, $response, $args) {

	User::verifyLogin();
    
    $request = new Request();
    $request->openNewRequest();
    
});

?>