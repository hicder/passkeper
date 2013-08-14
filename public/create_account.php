<?php
include("../includes/db_config.php");
require_once("../includes/defined_functions.php");
$response = array();
if(isset($_POST['newwebsite']) && isset($_POST['newusername']) && isset($_POST['newpassword']) && isset($_POST['username']) && isset($_POST['password'])){
	$login_username = $_POST['username'];
	$login_password = $_POST['password'];
	if(authenticate($login_username, $login_password)){
		$website = $_POST['newwebsite'];
		$username = $_POST['newusername'];
		$password = $_POST['newpassword'];
		
		$stmt = $mysqli->prepare("INSERT INTO acc_list(website, username, password) VALUES(?, ?, ?)");
		$stmt->bind_param("sss", $website, $username, $password);
		if($stmt->execute()){
			$response = array("result" => "success");
		}
		else{
			$response = array("result" => "failure");
		}
		echo json_encode($response);
	}
}
?>