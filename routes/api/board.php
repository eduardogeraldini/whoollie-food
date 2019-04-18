<?php

use \WHOOLLIEFOOD\MODEL\User;
use \WHOOLLIEFOOD\MODEL\Board;

// ---------------- DELETA ------------------------
$app->post('/api/board/delete/{id}', function($request, $response, $args) {
	
	User::verifyLogin();

	$board = new Board();
	$board->setIsDeleted(1);  
	$board->deleteBoard($args['id']);
	
	
});

// ---------------- EDITA ------------------------
$app->post('/api/board/update/{id}', function($request, $response, $args) {
	
	User::verifyLogin();

	$input = $request->getParsedBody();

	
	$board = new Board();

	$board->setVlBoard($input['vlBoard']);
	$board->setQtPlaces($input['qtPlaces']);
	//$board->setIsActive($input['isActive']);

	$board->editBoard($args['id']);
	
});


// -------------------- CRIA MESA --------------------------------------------
$app->post('/api/boards', function($request, $response, $args) {

    User::verifyLogin();
    
    $input = $request->getParsedBody();
	
    $board = new Board();
    
    $board->setVlBoard($input["vlBoard"]);
	$board->setQtPlaces($input["qtPlaces"]);
	//$board->setIsActive($input['isActive']);


    echo $board->createBoard();
	
});

// ------------------------------- LISTA MESAS -----------------------------------
$app->get('/api/boards', function($request, $response, $args) {

    User::verifyLogin();

    $board = new Board();

    echo $board->listAllBoards();
	
});

?>