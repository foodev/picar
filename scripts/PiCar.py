import RPi.GPIO as GPIO
import sys

GPIO.setmode(GPIO.BOARD)
GPIO.setwarnings(False)

MOTOR_FRONT = (7, 11)
MOTOR_BACK = (12, 16)

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
    try:
        if motor == 'front':
            motorUsed = 'front'
            MotorInit(MOTOR_FRONT)

            if action == 'on':
                if direction == 'clockwise':
                    MotorClockwise(MOTOR_FRONT)
                else:
                    MotorCounterClockwise(MOTOR_FRONT)
            else:
                MotorOff(MOTOR_FRONT)
        else:
            motorUsed = 'back'
            MotorInit(MOTOR_BACK)

            if action == 'on':
                if direction == 'clockwise':
                    MotorClockwise(MOTOR_BACK)
                else:
                    MotorCounterClockwise(MOTOR_BACK)
            else:
                MotorOff(MOTOR_BACK)
    except KeyboardInterrupt:
        if 'motorUsed' in locals():
            if motorUsed == 'front':
                MotorOff(MOTOR_FRONT)
            elif motorUsed == 'back':
                MotorOff(MOTOR_BACK)

        GPIO.cleanup()

def DriveForward():
    Drive('back', 'on', 'clockwise');

def DriveForwardStop():
    Drive('back', 'off');

def DriveBack():
    Drive('back', 'on', 'counter-clockwise');

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
