<?php
$apikey = 'YOUR_API_KEY';

$contents_europeana = fopen("http://www.europeana.eu/api/v2/search.json?wskey=$apikey&query=London&reusability=open&media=true", "r");
$json_europeana = stream_get_contents($contents_europeana);
fclose($contents_europeana);

print $json_europeana;
$data_europeana = json_decode($json_europeana);
print '<hr>';
print $data_europeana->totalResults;

print '<hr>';
// Table view of Europeana data
print '<table border=1><tr><th>Title</th><th>Data Provider</th><th>External Link</th><th>Thumbnail</th></tr>';

foreach($data_europeana->items as $item) {
	print '<td><a href="'.(isset($item->guid)?$item->guid:'').'">'.(isset($item->title[0])?$item->title[0]:'').'</a></td>';
	print '<td>'.(isset($item->dataProvider[0])?$item->dataProvider[0]:'').'</td>';
	print '<td><a href="'.(isset($item->edmIsShownAt[0])?$item->edmIsShownAt[0]:'').'">View at the provider website</a></td>';
	print '<td><a href="'.(isset($item->guid)?$item->guid:'').'"><img src="'.(isset($item->edmPreview[0])?$item->edmPreview[0]:'').'"></a></td></tr>';
}

print '</table>';
?>
