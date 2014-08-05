#!/bin/bash

`/home/pi/picar/bin/picar export`
`/home/pi/picar/scripts/stream.sh`
`python /home/pi/picar/scripts/startserver.py 8080`
