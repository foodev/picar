#!/bin/bash

#while true; do
#    read -p 'Which direction (left, up, right, down) ? ' PICAR_DIRECTION

case $1 in
    left)
        `python /home/pi/picar.py front on clockwise`
        ;;
    up)
        `python /home/pi/picar.py back on counter-clockwise`
        ;;
    right)
        `python /home/pi/picar.py front on counter-clockwise`
        ;;
    down)
        `python /home/pi/picar.py back on clockwise`
        ;;

    leftoff)
        `python /home/pi/picar.py front off`
        ;;
    rightoff)
        `python /home/pi/picar.py front off`
        ;;
    upoff)
        `python /home/pi/picar.py back off`
        ;;
    downoff)
        `python /home/pi/picar.py back off`
        ;;

    exit)
        `python /home/pi/picar.py front off`
        `python /home/pi/picar.py back off`
        exit 0
        ;;
esac
#done

exit 0
