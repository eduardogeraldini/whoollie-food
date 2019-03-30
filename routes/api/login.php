<?php 

use \WHOOLLIEFOOD\MODEL\User;

$app->post('/api/login', function ($request, $response, $args) {
	
    $login = $request->getParam('desLogin');
    $senha = $request->getParam('desPassword');

    echo User::login($login, $senha);

});

$app->get('/api/logout', function ($request, $response, $args) {

    User::logout();

});


?>