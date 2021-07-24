<?php
// Cross Origin Access
require('config/cors.php');
require('config/connection.php');




$student_id=$_POST["student_id"];
$doc_url=$_POST["doc_url"];
$app_type=$_POST["app_type"];
$filename=$_POST["filename"];
$action=$_POST["action"];
$table=$_POST["tb"];


if($_POST["action"]=="studentLeave"){

  $sql = "INSERT INTO `$table`(studentId,doc_url,application_type,filename) VALUES ($student_id , '$doc_url','$app_type','$filename')";
        $result =mysqli_query($conn, $sql); 
        if($result){
		  echo json_encode("success");
	}else{
		echo json_encode("query execution failed");
}
		
      	
	mysqli_close($conn);
return;
}

?>