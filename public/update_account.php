<?php
    include("../includes/db_config.php");
    require_once("../includes/defined_functions.php");
    if(isset($_POST['website']) && isset($_POST['username']) && isset($_POST['password'])){
	$website = $_POST['website'];
	$username = $_POST['username'];
	$password = $_POST['password'];

        $stmt = $mysqli->prepare("UPDATE acc_list SET username=?, password=? WHERE website=?");
        $stmt->bind_param("sss", $username, $password, $website);
        $stmt->execute();
    }
?>