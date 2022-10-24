<?php
define('MB',1048576);
// function filterRequest($reqestName){

//    return htmlspecialchars(strip_tags($_POST[$reqestName]));

// }

function imageUpload($imageRequest){
   global $msgErro;
   $imagename = rand(1000,10000) . $_FILES[$imageRequest]['name'];
   $imagetmp = $_FILES[$imageRequest]['tmp_name'];
   $imagesize = $_FILES[$imageRequest]['size'] ;
   $allowExt = array("jpg", "png","gif","pdf");
   $strToArray = explode(".",$imagename);
   $ext= end($strToArray);
   $ext=strtolower($ext);
   if(!empty($imagename) && !in_array($ext,$allowExt)){
      $msgErro[]="Ext";
   }
   if($imagesize> 10 * MB){
      $msgErro[]="size";
   }
   if(empty($msgErro)){
      move_uploaded_file($imagetmp,"../upload/" . $imagename);
      return $imagename;
   }else{
      return "fail";
   }


}


function deleteFile($dir,$imagename){
   if(file_exists($dir ."/". $imagename)){
      unlink($dir ."/". $imagename);
   }
}


function checkAuthenticate(){
    if (isset($_SERVER['PHP_AUTH_USER'])  && isset($_SERVER['PHP_AUTH_PW'])) {

        if ($_SERVER['PHP_AUTH_USER'] != "hadeel" ||  $_SERVER['PHP_AUTH_PW'] != "hadeel123456"){
            header('WWW-Authenticate: Basic realm="My Realm"');
            header('HTTP/1.0 401 Unauthorized');
            echo 'Page Not Found';
            exit;
        }
    } else {
        exit;
    }}
?>