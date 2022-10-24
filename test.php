<?php

include "./connect.php";

$imagename = $_POST["imagename"];
deleteFile("./upload",$imagename);

?>