<?php

$username = 'u666708222_vamsi';
$password = 'Vamsi12345';
$dbname = 'u666708222_vamsi';
$servername = 'mnds.tech';
$port=3306;

$conn = mysqli_connect($servername, $username, $password, $dbname, $port);

if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

?>