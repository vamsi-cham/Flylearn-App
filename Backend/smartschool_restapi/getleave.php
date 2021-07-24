<?php
// Cross Origin Access
require('config/cors.php');
require('config/connection.php');


$teacher_id=$_POST["teacher_id"];
$action=$_POST["action"];
$table=$_POST["tb"];


if($action=="getleave"){

        $sql = "SELECT * FROM $table WHERE teacherId = $teacher_id ORDER BY created_time DESC";
        $result = $conn->query($sql);


    if($result){// run query
        $db_data = array();
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }
         // Send back the complete records as a json
          $param=[
                'status'=>200,
                'message'=>"success",
                'data'=>$db_data,
            ];

        
            echo json_encode($param);
        }else{

            $param=[
                'status'=>201,
                'message'=>$invalid,
                'data'=>[],
            ];
            echo json_encode($param);

        }
    }else{

        $param=[
            'status'=>500,
            'message'=>'error',
            'data'=>[],
        ];

        echo json_encode($param);
    }


}

$conn->close();

?>