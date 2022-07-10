<?php
$servername = "localhost";
$username   = "moneymon_276984_mytutor";
$password   = "7)y.MqB~mgS;";
$dbname     = "moneymon_276984_mytutor_db";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>