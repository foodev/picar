# PiCar

Some scripts + a webinterface to control a remote car with a raspberry pi

## Requirements
- git
- ghc (or any other Haskell compiler)
- nodejs (+ [websocket module](https://github.com/theturtle32/WebSocket-Node))

## Installation
- clone this repository to `$HOME` on your raspberry pi
    + `$ git clone https://github.com/foodev/picar.git $HOME/picar`
- compile `picar.hs` as `picar` (you can use the `build.sh` script for that)
    + `$ mkdir $HOME/picar/bin`
    + `$ bash $HOME/picar/build.sh`
- add the `$HOME/picar/bin` to your `PATH` variable
    + `$ echo 'PATH="$HOME/picar/bin:$PATH"' >> $HOME/.profile`
    + `$ source $HOME/.profile`
- initialize the pins and start the webserver
    + `picar export`
    + `picar init`
    + `picar startwebserver`
- navigate your browser to `http://localhost:8080`
    + to access the webinterface from another pc, replace `localhost` with the ip of the raspberry pi
- :)
