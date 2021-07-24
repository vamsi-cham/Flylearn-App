<?php
// Cross Origin Access
require('config/cors.php');
require('config/connection.php');


$meeting_id=$_POST["meeting_id"];
$action=$_POST["action"];
$table=$_POST["tb"];


if($action=="deleteclass"){


  $sql = "DELETE FROM $table WHERE meeting_id = $meeting_id";
        $result = $conn->query($sql);
        if($conn->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }


$conn->close();
return;
}

?>