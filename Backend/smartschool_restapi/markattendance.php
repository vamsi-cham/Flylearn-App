<?php
// Cross Origin Access
require('config/cors.php');
require('config/connection.php');


$teacher_id=$_POST["teacher_id"];
$ipaddress=$_POST["ipaddress"];
$action=$_POST["action"];
$table=$_POST["tb"];


if($action=="markattendance"){


  $sql = "INSERT INTO $table (teacherId,ipaddress) VALUES ('$teacher_id' , '$ipaddress')";
        $result = $conn->query($sql);
        echo json_encode("success");


$conn->close();
return;
}

?>