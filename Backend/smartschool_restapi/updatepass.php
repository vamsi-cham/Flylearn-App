<?php
// Cross Origin Access
require('config/cors.php');
require('config/connection.php');


$user_id=$_POST["user_id"];
$password=$_POST["password"];
$action=$_POST["action"];
$table=$_POST["tb"];


if($action=="updatepassword"){


  $sql = "UPDATE $table SET password = '$password' WHERE id = $user_id ";
        if($conn->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }


$conn->close();
return;
}

?>