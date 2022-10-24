<?php
include "../connect.php";

$noteid = $_POST["id"];

$title = $_POST["title"];

$content = $_POST["content"];

$image = $_POST["image"];

if(isset($_FILES['file'])){
    deleteFile("../upload",$image);
    $image=imageUpload("file");
}

$stmt = $con->prepare(
    "UPDATE `notes` SET
     `notes_title`= ? ,
     `notes_content`= ?,
     `image` =?
       WHERE notes_id = ?");

$stmt->execute(array($title,$content,$image,$noteid));

$count = $stmt->rowCount();

if($count>0){
echo json_encode(array("status"=>"success"));
}else{
    echo json_encode(array("status"=>"fail"));

}




?>