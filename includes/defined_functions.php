<?php
function generate_salt($length){
	$ran_string = md5(uniqid(mt_rand(), true));
	$base64_string = base64_encode($ran_string);
	$mod_base64_string = str_replace('+', '.', $base64_string);
	$salt = substr($mod_base64_string, 0, $length);
	return $salt;
}

function password_encrypt($password){
	$hash_format = "$2y$10$";
	$salt_length = 22;
	$salt = generate_salt($salt_length);
	$format_and_salt = $hash_format.$salt;
	$hash = crypt($password, $format_and_salt);	
	return $hash;
}

function password_check($password, $existing_hash){
	$hash = crypt($password, $existing_hash);
	if($hash == $existing_hash){
		return true;
	}
	else{
		return false;
	}
}

function retrieve_hashed_password($username){
	global $mysqli;
	$stmt = $mysqli->prepare("SELECT password FROM admin WHERE username = ?");
	$stmt->bind_param("s", $username);
	$hashed_password = NULL;
	if($stmt->execute()){
		$stmt->bind_result($hashed_password);
		$stmt->fetch();
	}
	return $hashed_password;
}

function authenticate($username, $password){
	$hashed_password = retrieve_hashed_password($username);
	return password_check($password, $hashed_password);
}

function get_all_passwords(){
	global $mysqli;
	$stmt = $mysqli->prepare("SELECT * FROM acc_list");
	$returned_array = array();
	$stmt->execute();
	$result = $stmt->get_result();
	while($myrow = $result->fetch_assoc()){
		array_push($returned_array, $myrow);
		
	}
	
	return $returned_array;
}

function check_username_exist($username){
	
}

?>