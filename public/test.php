<?php
//This file is to test whether php files are working correctly
$url = '';  //enter URL of database here
$data = array('username' => '', 'password' => ''); //username and password information here

// use key 'http' even if you send the request to https://...
$options = array(
    'http' => array(
        'header'  => "Content-type: application/x-www-form-urlencoded\r\n",
        'method'  => 'POST',
        'content' => http_build_query($data),
    ),
);
$context  = stream_context_create($options);
$result = file_get_contents($url, false, $context);
echo $result;
?>