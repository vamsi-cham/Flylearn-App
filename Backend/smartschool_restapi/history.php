<?php
// Cross Origin Access
require('config/cors.php');
require('config/connection.php');


$client_id=$_POST["client_id"];
$ipaddress=$_POST["ipaddress"];
$device=$_POST["device"];
$action=$_POST["action"];
$table=$_POST["tb"];


if($action=="history"){

        $sql = "INSERT INTO $table (client_id, ipaddress, device) VALUES ('$client_id', '$ipaddress', '$device')";
        $result = $conn->query($sql);

        echo json_encode("success");
        $conn->close();
        return;


}



?>