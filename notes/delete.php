<?php
include "../connect.php";


$noteid = $_POST["id"];
$imgname = $_POST["imgname"];

$stmt = $con->prepare("DELETE FROM notes WHERE `notes_id` = ? ");

$stmt->execute(array($noteid));

$count = $stmt->rowCount();

if($count>0){
     deleteFile("../upload",$imgname);

echo json_encode(array("status"=>"success"));
}else{
    echo json_encode(array("status"=>"fail"));

}




?>