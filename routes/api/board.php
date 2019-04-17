<?php

use \WHOOLLIEFOOD\MODEL\User;
use \WHOOLLIEFOOD\MODEL\Board;

$app->post('/api/boards', function($request, $response, $args) {

    User::verifyLogin();
    
    $input = $request->getParsedBody();
	
    $board = new Board();
    
    $board->setVlBoard($input["vlBoard"]);
	$board->setQtPlaces($input["qtPlaces"]);


    $board->createBoard();
	
});


$app->get('/api/boards', function($request, $response, $args) {

    User::verifyLogin();

    echo $board->listAllBoards();
	
});

?>