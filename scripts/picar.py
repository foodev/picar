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
    #MOTOR_PWM[0].start(1)
    #MOTOR_PWM[1].start(1)

def MotorOff(motor):
    GPIO.output(motor[0], GPIO.LOW)
    GPIO.output(motor[1], GPIO.LOW)
    #MOTOR_PWM[0].stop()
    #MOTOR_PWM[1].stop()

def MotorClockwise(motor):
    GPIO.output(motor[0], GPIO.LOW)
    GPIO.output(motor[1], GPIO.HIGH)

def MotorCounterClockwise(motor):
    GPIO.output(motor[0], GPIO.HIGH)
    GPIO.output(motor[1], GPIO.LOW)

try:
    #while True:
    if sys.argv[1] == 'front':
        motorUsed = 'front'
        MotorInit(MOTOR_FRONT)

        if sys.argv[2] == 'on':
            if sys.argv[3] == 'clockwise':
                MotorClockwise(MOTOR_FRONT)
            else:
                MotorCounterClockwise(MOTOR_FRONT)
        else:
            MotorOff(MOTOR_FRONT)
            #break
    else:
        motorUsed = 'back'
        MotorInit(MOTOR_BACK)

        if sys.argv[2] == 'on':
            if sys.argv[3] == 'clockwise':
                MotorClockwise(MOTOR_BACK)
            else:
                MotorCounterClockwise(MOTOR_BACK)
        else:
            MotorOff(MOTOR_BACK)
                #break
except KeyboardInterrupt:
    if 'motorUsed' in locals():
        if motorUsed == 'front':
            MotorOff(MOTOR_FRONT)
        elif motorUsed == 'back':
            MotorOff(MOTOR_BACK)

    GPIO.cleanup()
