<?php
include "../connect.php";

$userName = $_POST["userName"];

$email = $_POST["email"];

$password = $_POST["password"];

//$updataApp = filterRequest(0);

$stmt = $con->prepare(
    "INSERT INTO `users`( `userName`, `email`, `password`) VALUES (?,?,?)");

$stmt->execute(array($userName,$email,$password));

$count = $stmt->rowCount();

if($count>0){
echo json_encode(array("status"=>"success"));
}else{
    echo json_encode(array("status"=>"fail"));

}




?>