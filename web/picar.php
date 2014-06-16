<?php

$action = isset($_POST['action']) ? $_POST['action'] : null;
$direction = isset($_POST['direction']) ? $_POST['direction'] : null;

$cmd = 'sudo python /home/pi/picar/scripts/picarControl.py %s %s';

exec(sprintf($cmd, $action, $direction), $output);

echo sprintf($cmd, $action, $direction) . PHP_EOL;
var_dump($output);
