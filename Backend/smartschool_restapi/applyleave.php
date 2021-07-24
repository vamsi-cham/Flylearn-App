<?php
// Cross Origin Access
require('config/cors.php');
require('config/connection.php');


$teacher_id=$_POST["teacher_id"];
$doc_url=$_POST["doc_url"];
$apptype=$_POST["apptype"];
$filename=$_POST["filename"];
$action=$_POST["action"];
$table=$_POST["tb"];


if($action=="applyleave"){


  $sql = "INSERT INTO $table (teacherId,doc_url,application_type,filename) VALUES ('$teacher_id' , '$doc_url','$apptype','$filename')";
        $result = $conn->query($sql);
        echo json_encode("success");


$conn->close();
return;
}

?>