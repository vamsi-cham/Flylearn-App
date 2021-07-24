<?php
// Cross Origin Access
require('config/cors.php');
require('config/connection.php');


$meeting_id=$_POST["meeting_id"];
$class_status=$_POST["class_status"];
$action=$_POST["action"];
$table=$_POST["tb"];


if($action=="updateclassstatus"){


  $sql = "UPDATE $table SET class_status = '$class_status' WHERE meeting_id = $meeting_id ";
        if($conn->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }


$conn->close();
return;
}

?>