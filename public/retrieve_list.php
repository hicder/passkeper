<?php
require_once("db_config.php");
$response = array();
require_once("defined_functions.php");
if(isset($_POST['username']) && isset($_POST['password'])){
	$logged_in = authenticate($_POST['username'], $_POST['password']);
	if($logged_in){
		$response['status'] = "success";
		$response['results'] = get_all_passwords();
	}
	else{
		$response['status'] = "failure";
		$response['results'] = NULL;
	}
	echo json_encode($response);
}
?>