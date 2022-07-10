<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");
$subID = $_POST['subID'];
$email = $_POST['email'];
$cartqty = "1";
$carttotal = 0;
$sqlinsert = "SELECT * FROM tbl_carts WHERE user_email = '$email' AND subject_id = '$subID'";
$result = $conn->query($sqlinsert);
$number_of_result = $result->num_rows;

if ($number_of_result > 0) {
    while($row = $result->fetch_assoc()) {
	    $cartqty = $row['cart_qty'];
	}
	$cartqty = $cartqty + 1;
	$updatecart = "UPDATE `tbl_carts` SET `cart_qty`= '$cartqty' WHERE user_email = '$email' AND subject_id = '$subID'";
	$conn->query($updatecart);
// 	$response = array('status' => 'success', 'data' => null);
// 	sendJsonResponse($response);
} else{
    $addcart = "INSERT INTO `tbl_carts`(`user_email`, `subject_id`, `cart_qty`) VALUES ('$email','$subID', '$cartqty')";
    if ($conn->query($addcart) === TRUE) {
//         $response = array('status' => 'success', 'data' => null);
// 		sendJsonResponse($response);
// 		return;
	}else{
	    $response = array('status' => 'failed', 'data' => null);
		sendJsonResponse($response);
		return;
    }
}
$sqlgetqty = "SELECT * FROM tbl_carts WHERE user_email = '$email'";
$result = $conn->query($sqlgetqty);
$number_of_result = $result->num_rows;
$carttotal = 0;
while($row = $result->fetch_assoc()) {
    $carttotal = $row['cart_qty'] + $carttotal;
}
$mycart = array();
$mycart['carttotal'] =$carttotal;
$response = array('status' => 'success', 'data' => $mycart);
sendJsonResponse($response);

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>
