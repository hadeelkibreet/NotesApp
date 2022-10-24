<?php
include "../connect.php";
$stmt=$con->prepare("SELECT * FROM users");
$stmt->execute();
$users=$stmt->fetchAll(PDO::FETCH_ASSOC);

print_R($users);


?>