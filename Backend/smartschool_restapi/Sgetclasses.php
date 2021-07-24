<?php
// Cross Origin Access
require('config/cors.php');
require('config/connection.php');


$Sclass=$_POST["Sclass"];
$Section=$_POST["Section"];
$class_status=$_POST["class_status"];
$action=$_POST["action"];
$table=$_POST["tb"];


if($action=="Sgetclasses"){

        $sql = "SELECT * FROM $table WHERE class = $Sclass AND section='$Section' AND class_status <> '$class_status' AND YEAR(fromdate) = YEAR(NOW()) AND MONTH(fromdate) = MONTH(NOW()) AND DAY(fromdate) = DAY(NOW()) ORDER BY fromdate ASC";
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