<?php

$apikey = 'YOUR_API_KEY';

$contents_harvard = fopen("https://api.harvardartmuseums.org/object?apikey=$apikey&keyword=andromeda", 'r');
$json_harvard = stream_get_contents($contents_harvard);
fclose($contents_harvard);
print($json_harvard);
 // For display purposes, <hr> are added several times in this file
print '<hr>';
$data_harvard = json_decode($json_harvard);
print $data_harvard->info->totalrecords;
print '<hr>';

foreach($data_harvard->records as $item) {
	print '<td>'.(isset($item->title)?$item->title:'').'</td>';
	print '<td>'.(isset($item->dated)?$item->dated:'').'</td>';
  print '<td>'.(isset($item->creditline)?$item->creditline:'').'</td>';
	print '<td><a href="'.(isset($item->url)?$item->url:'').'">View at the website</a></td>';
	print '<td><a href="'.(isset($item->isShownAt)?$item->primaryimageurl:'').'"><img src="'.(isset($item->primaryimageurl)?$item->primaryimageurl:'').'" height="100" width="100"></a></td></tr>';
	print '<br>';
}

?>
