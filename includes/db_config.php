<?php
define('DB_USER', "hieu");
define('DB_PASSWORD' "");
define('DB_DATABASE', "passkeeper");
define('DB_SERVER', "http://www.google.com");

$mysqli = new mysqli(DB_SERVER, DB_USER, DB_PASSWORD, DB_DATABASE);
?>