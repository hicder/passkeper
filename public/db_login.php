<?php
include("../includes/db_config.php");
?>

<?php
require_once("../includes/defined_functions.php");
?>

<?php
	$result = array();
	if(isset($_POST['username']) && isset($_POST['password'])){
		$username = $_POST['username'];
		$password = $_POST['password'];	
		if(authenticate($username, $password)){
			$result['result'] = "success";
		}
		else{
			$result['result'] = "failure";
		}
	}
	else{
		$result['result'] = "failure";
	}
	echo json_encode($result);

?>