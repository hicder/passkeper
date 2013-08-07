<?php
    require_once("../includes/defined_functions.php");
    include("../includes/db_config.php");
    
    if(isset($_GET['username'])  && isset($_GET['password'])){
        $username = $_GET['username'];
        $password = $_GET['password'];
        $hashed_password = password_encrypt($password);
        
        $stmt = $mysqli->prepare ( "INSERT INTO admin(username, password) VALUES (?,?)" );
        $stmt->bind_param("ss", $username, $hashed_password);
        $stmt->execute();
    }
?>