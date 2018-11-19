<?php

$apikey = 'YOUR_API_KEY';

$VARIABLE1 = fopen('HTTP', 'r');
$VARIABLE2 = stream_get_contents($VARIABLE1);
fclose($VARIABLE1);
$VARIABLE3 = json_decode($VARIABLE2);

foreach($data as $item) {
    print 'WHATEVER YOU WANT TO DISPLAY';
}

?>
