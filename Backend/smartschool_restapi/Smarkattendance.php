<?php
// Cross Origin Access
require('config/cors.php');
require('config/connection.php');


$student_id=$_POST["student_id"];
$ipaddress=$_POST["ipaddress"];
$action=$_POST["action"];
$table=$_POST["tb"];


if($action=="Smarkattendance"){


  $sql = "INSERT INTO $table (studentId,ipaddress) VALUES ($student_id , '$ipaddress')";
        $result = $conn->query($sql);
        echo json_encode("success");


$conn->close();
return;
}

?>