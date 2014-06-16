import sys
import PiCar

action = sys.argv[1]
direction = sys.argv[2]

if action == 'on':
    if direction == 'up':
        PiCar.DriveForward()
    elif direction == 'down':
        PiCar.DriveBack()
    elif direction == 'left':
        PiCar.DriveLeft()
    elif direction == 'right':
        PiCar.DriveRight()
if action == 'off':
    if direction == 'up':
        PiCar.DriveForwardStop()
    elif direction == 'down':
        PiCar.DriveBackStop()
    elif direction == 'left':
        PiCar.DriveLeftStop()
    elif direction == 'right':
        PiCar.DriveRightStop()
