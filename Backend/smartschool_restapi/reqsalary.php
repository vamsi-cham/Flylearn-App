<?php
// Cross Origin Access
require('config/cors.php');
require('config/connection.php');


$teacher_id=$_POST["teacher_id"];
$month=$_POST["month"];
$action=$_POST["action"];
$table=$_POST["tb"];


if($action=="reqsalary"){


  $sql = "INSERT INTO $table (teacherId,month) VALUES ('$teacher_id' , '$month')";
        $result = $conn->query($sql);
        echo json_encode("success");


$conn->close();
return;
}

?>