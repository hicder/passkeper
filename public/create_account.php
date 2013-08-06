<?php
include("db_config.php");
$mysqli = new mysqli("");	
$response = array();
if(isset($_POST['website']) && isset($_POST['username']) && isset($_POST['password'])){
	$website = $_POST['website'];
	$username = $_POST['username'];
	$password = $_POST['password'];
	
	$stmt = $mysqli->prepare("INSERT INTO acc_list(website, username, password) VALUES(?, ?, ?)");
	$stmt->bind_param("sss", $website, $username, $password);
	if($stmt->execute()){
		$response = ["result" => "success"];
	}
	else{
		$response = ["result" => "error"];
	}
	echo json_encode($response);
}
?>