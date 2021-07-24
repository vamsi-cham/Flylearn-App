<?php
// Cross Origin Access
require('config/cors.php');
require('config/connection.php');

if($_POST["action"]=="scheduleClass"){

$teacher_id=$_POST["teacher_id"];
$class=$_POST["class"];
$section=$_POST["section"];
$subject=$_POST["subject"];
$fromdate=$_POST["fromdate"];
$todate=$_POST["todate"];
$class_status=$_POST["class_status"];
$title=$_POST["title"];
$table=$_POST["tb"];


  $sql = "INSERT INTO `$table`(teacherId, class, section, subject, fromdate, todate, class_status, title) VALUES ($teacher_id , '$class','$section','$subject','$fromdate','$todate','$class_status', '$title')";
        $result =mysqli_query($conn, $sql); //query execution
	if($result){
		  echo json_encode("success");
	}else{
		echo json_encode("query execution failed");
}
		
      	
	mysqli_close($conn);
return;
}

?>