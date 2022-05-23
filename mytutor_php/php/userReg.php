<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");
$name = addslashes($_POST['name']);
$email = addslashes($_POST['email']);
$phone = $_POST['phone'];
$pass = sha1($_POST['pass']);
$add = $_POST['add'];
$base64image = $_POST['image'];
$sqlinsert = "INSERT INTO `tbl_user`(`user_name`, `user_email`, `user_phone`, `user_pass`, `user_add`, `image`) VALUES ('$name','$email','$phone','$pass','$add','$base64image')";

if ($conn->query($sqlinsert) === TRUE) {
    $response = array('status' => 'success', 'data' => null);
    $filename = mysqli_insert_id($conn);
    $decoded_string = base64_decode($base64image);
    $path = '../images/userpic/' . $filename . '.png';
    $is_written = file_put_contents($path, $decoded_string);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>