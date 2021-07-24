<?php
// Cross Origin Access
require('config/cors.php');
require('config/connection.php');


$client_id=$_POST["client_id"];
$action=$_POST["action"];
$table=$_POST["tb"];


if($action=="gethistory"){

        $sql = "SELECT * FROM $table WHERE client_id = $client_id ORDER BY datetime DESC";
        $result = $conn->query($sql);


    if($result){// run query
        $db_data = array();
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }
         // Send back the complete records as a json

        
            echo json_encode($db_data);
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