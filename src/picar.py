import RPi.GPIO as GPIO
import sys

GPIO.setmode(GPIO.BOARD)
GPIO.setwarnings(False)

MOTORS = {
    'front': (7, 11),
    'back': (12, 16)
}

def MotorInit(motor):
    GPIO.setup(motor[0], GPIO.OUT)
    GPIO.setup(motor[1], GPIO.OUT)
    MOTOR_PWM = (GPIO.PWM(motor[0], 0.5), GPIO.PWM(motor[0], 0.5))

def MotorOff(motor):
    GPIO.output(motor[0], GPIO.LOW)
    GPIO.output(motor[1], GPIO.LOW)

def MotorClockwise(motor):
    GPIO.output(motor[0], GPIO.LOW)
    GPIO.output(motor[1], GPIO.HIGH)

def MotorCounterClockwise(motor):
    GPIO.output(motor[0], GPIO.HIGH)
    GPIO.output(motor[1], GPIO.LOW)

def Drive(motor, action, direction = None):
    motorUsed = None

    try:
        motorUsed = motor
        MotorInit(MOTORS[motor])

        if action == 'on':
            if direction == 'clockwise':
                MotorClockwise(MOTORS[motor])
            else:
                MotorCounterClockwise(MOTORS[motor])
        else:
            MotorOff(MOTORS[motor])
    except KeyboardInterrupt:
        if motorUsed in MOTORS:
            MotorOff(MOTORS[motorUsed])

        GPIO.cleanup()

def DriveForward():
    Drive('back', 'on', 'counter-clockwise');

def DriveForwardStop():
    Drive('back', 'off');

def DriveBack():
    Drive('back', 'on', 'clockwise');

def DriveBackStop():
    Drive('back', 'off');

def DriveLeft():
    Drive('front', 'on', 'clockwise');

def DriveLeftStop():
    Drive('front', 'off');

def DriveRight():
    Drive('front', 'on', 'counter-clockwise');

def DriveRightStop():
    Drive('front', 'off');

if __name__ == "__main__":
    if len(sys.argv) == 4:
        Drive(sys.argv[1], sys.argv[2], sys.argv[3])
    else:
        Drive(sys.argv[1], sys.argv[2])

