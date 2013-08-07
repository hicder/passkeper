<?php
define('DB_USER', "");
define('DB_PASSWORD', "");
define('DB_DATABASE', "");
define('DB_SERVER', "engr-cpanel-mysql.engr.illinois.edu");

$mysqli = new mysqli(DB_SERVER, DB_USER, DB_PASSWORD, DB_DATABASE);
?>