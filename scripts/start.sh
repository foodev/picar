#!/bin/bash

# export the pins
/home/pi/picar/bin/picar export

# init the webcam to make every 2 seconds a picture
fswebcam -b -r 1280x720 --jpeg 95 --no-banner -q -l 2 /home/pi/picar/web/stream.jpg

# start the webserver
python /home/pi/picar/scripts/startserver.py 8080
