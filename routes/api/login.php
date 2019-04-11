<?php 

use \WHOOLLIEFOOD\MODEL\User;

$app->post('/api/users/update/{id}', function ($request, $response, $args) {
    
    User::verifyLogin();
    
    $login = $request->getParam('desLogin');
    $senha = $request->getParam('desPassword');

    User::updatePassword($args['id'], $login, $senha);

});

$app->post('/api/login', function ($request, $response, $args) {
	
    $login = $request->getParam('desLogin');
    $senha = $request->getParam('desPassword');

    echo User::login($login, $senha);

});

$app->get('/api/logout', function ($request, $response, $args) {

    User::logout();

});


$app->get('/api/users/{id}', function($request, $response, $args) {

    User::verifyLogin();

    echo User::returnUserLoginById($args['id']);
	
});


?>