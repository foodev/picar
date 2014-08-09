# PiCar

Some scripts + a webinterface to control a remote car with a raspberry pi

## Requirements
- git
- gcc or ghc
- nodejs (+ websocket module)
- fswebcam

## Installation
- clone this repository to `/home/pi` on your raspberry pi
    + `git clone https://github.com/foodev/picar.git /home/pi/picar`
- compile `picar.c` _or_ `picar.hs` as `picar` inside a `bin` folder
    + `mkdir /home/pi/picar/bin`
    + `gcc /home/pi/picar/src/picar.c -o /home/pi/picar/bin/picar` _or_
    + `ghc /home/pi/picar/src/picar.hs -o /home/pi/picar/bin/picar`
- start the server with `bash /home/pi/picar/scripts/start.sh`
- navigate your browser to `http://localhost:8080`
    + to access the webinterface from another pc, replace `localhost` with the ip of the raspberry pi
- :)
