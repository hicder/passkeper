<?php
include("../includes/db_config.php");
require_once("../includes/defined_functions.php");
$response = array();
if(isset($_POST['username']) && isset($_POST['password'])){
	$logged_in = authenticate($_POST['username'], $_POST['password']);
	if($logged_in){
 		$response['status'] = "success";
		$response['results'] = get_all_passwords();
	}
}
else{
	$response['status'] = "failure";
	$response['results'] = NULL;
}
echo json_encode($response);
?>