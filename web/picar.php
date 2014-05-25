<?php

$action = isset($_POST['action']) ? $_POST['action'] : null;
$direction = isset($_POST['direction']) ? $_POST['direction'] : null;

$cmd = $direction;

if ($action == 'off') {
    $cmd .= 'off';
}

exec(sprintf('sudo /home/pi/picarControl.sh %s', $cmd), $output);

echo $action . ' - ' . $direction . PHP_EOL;
echo $cmd . PHP_EOL;
echo sprintf('sudo /home/pi/picarControl.sh %s', $cmd);
var_dump($output);

