<?php

use \WHOOLLIEFOOD\MODEL\User;
use \WHOOLLIEFOOD\MODEL\Board;

$app->post('/api/boards', function($request, $response, $args) {

    User::verifyLogin();
    
    $input = $request->getParsedBody();
	
    $board = new Board();
    
    $board->setVlBoard($input["vlBoard"]);
	$board->setQtPlaces($input["qtPlaces"]);
	$board->setIsActive($input['isActive']);

    echo $board->createBoard();
	
});

$app->get('/api/boards', function($request, $response, $args) {

    User::verifyLogin();

    $board = new Board();

    echo $board->listAllBoards();
	
});

$app->get('/api/boards/{id}', function($request, $response, $args) {

	User::verifyLogin();

    $board = new Board();
	echo $board->listBoardById($args['id']);
	
});

$app->post('/api/board/delete/{id}', function($request, $response, $args) {
	
	User::verifyLogin();

	$board = new Board();
	$board->setIsDeleted(1);  
	echo $board->deleteBoard($args['id']);
	
	
});

$app->post('/api/board/edit/{id}', function($request, $response, $args) {
    
    User::verifyLogin();

    $input = $request->getParsedBody();
	
	$board = new Board();
    
    $board->setIdBoard($args["id"]);
	$board->setVlBoard($input['vlBoard']);
	$board->setQtPlaces($input['qtPlaces']);
	$board->setIsActive($input['isActive']);

    echo $board->editBoard();
	
});

?>