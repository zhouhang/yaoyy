<?php 

	header("Content-Type: text/html; charset=UTF-8");

	sleep(1);//效果演示，该句可移除;

	$arr = array (
		'id'=>"221144141",
		'name'=>"三棱",
		'level'=>"过20号筛，直径2cm以上",
		'company'=>"陈数理",
		'mobile'=>"1844474774", 
		"price"=> "15元/公斤",
		"number"=> "100公斤",
		"cost"=> "1500元",
		"status"=> "已发货",
		"ids"=> "211414474，5547417"
	); 


	echo json_encode($arr);
?>