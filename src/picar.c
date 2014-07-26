#include <stdio.h>
#include <stdbool.h>
#include <string.h>

#define MOTOR_FRONT_0 4
#define MOTOR_FRONT_1 17
#define MOTOR_BACK_0 18
#define MOTOR_BACK_1 23

#define HIGH "1"
#define LOW "0"

bool isExported(int pin) {
    FILE *file;
    char filename[22];

    sprintf(filename, "/sys/class/gpio/gpio%i", pin);

    if ((file = fopen(filename, "r")) == NULL) {
        return false;
    }

    fclose(file);
    return true;
}

void writeToGPIO(int pin, char commandName[], char commandValue[]) {
    FILE *file;
    char filename[35];

    sprintf(filename, "/sys/class/gpio/gpio%i/%s", pin, commandName);

    if ((file = fopen(filename, "w")) == NULL) {
        fprintf(stderr, "Failed to open file '%s'\n", filename);
    }

    fprintf(file, "%s", commandValue);
    fclose(file);
}

void exportPin(int pin) {
    FILE *file;

    if ((file = fopen("/sys/class/gpio/export", "w")) != NULL) {
        fprintf(file, "%i", pin);
        fclose(file);
    }
}

void unexportPin(int pin) {
    FILE *file;

    if ((file = fopen("/sys/class/gpio/unexport", "w")) != NULL) {
        fprintf(file, "%i", pin);
        fclose(file);
    }
}

void driveForward(char action[]) {
    if (strcmp(action, "start") == 0) {
        // drive forward
        writeToGPIO(MOTOR_BACK_0, "value", HIGH);
        writeToGPIO(MOTOR_BACK_1, "value", LOW);
    } else if (strcmp(action, "stop") == 0) {
        // stop driving forward
        writeToGPIO(MOTOR_BACK_0, "value", LOW);
        writeToGPIO(MOTOR_BACK_1, "value", LOW);
    }
}

void driveBack(char action[]) {
    if (strcmp(action, "start") == 0) {
        // drive back
        writeToGPIO(MOTOR_BACK_0, "value", LOW);
        writeToGPIO(MOTOR_BACK_1, "value", HIGH);
    } else if (strcmp(action, "stop") == 0) {
        // stop driving back
        writeToGPIO(MOTOR_BACK_0, "value", LOW);
        writeToGPIO(MOTOR_BACK_1, "value", LOW);
    }
}

void driveLeft(char action[]) {
    if (strcmp(action, "start") == 0) {
        // drive left
        writeToGPIO(MOTOR_FRONT_0, "value", LOW);
        writeToGPIO(MOTOR_FRONT_1, "value", HIGH);
    } else if (strcmp(action, "stop") == 0) {
        // stop driving left
        writeToGPIO(MOTOR_FRONT_0, "value", LOW);
        writeToGPIO(MOTOR_FRONT_1, "value", LOW);
    }
}

void driveRight(char action[]) {
    if (strcmp(action, "start") == 0) {
        // drive right
        writeToGPIO(MOTOR_FRONT_0, "value", HIGH);
        writeToGPIO(MOTOR_FRONT_1, "value", LOW);
    } else if (strcmp(action, "stop") == 0) {
        // stop driving right
        writeToGPIO(MOTOR_FRONT_0, "value", LOW);
        writeToGPIO(MOTOR_FRONT_1, "value", LOW);
    }
}

int main(int argc, char *argv[]) {
    // toggle drive for each direction
    if (argc == 3) {
        // check if the pins are exported
        if (isExported(MOTOR_FRONT_0) == false ||
            isExported(MOTOR_FRONT_1) == false ||
            isExported(MOTOR_BACK_0) == false ||
            isExported(MOTOR_BACK_1) == false) {
            fprintf(stderr, "You have to export the pins first\n");

            return 1;
        }

        // setup the pins as output
        writeToGPIO(MOTOR_FRONT_0, "direction", "out");
        writeToGPIO(MOTOR_FRONT_1, "direction", "out");
        writeToGPIO(MOTOR_BACK_0, "direction", "out");
        writeToGPIO(MOTOR_BACK_1, "direction", "out");

        switch (*argv[1]) {
            case 'f':
                driveForward(argv[2]);
                break;

            case 'b':
                driveBack(argv[2]);
                break;

            case 'l':
                driveLeft(argv[2]);
                break;

            case 'r':
                driveRight(argv[2]);
                break;
        }
    } else if (argc == 2) {
        // export the pins
        if (strcmp(argv[1], "export") == 0) {
            exportPin(MOTOR_FRONT_0);
            exportPin(MOTOR_FRONT_1);
            exportPin(MOTOR_BACK_0);
            exportPin(MOTOR_BACK_1);

            return 0;
        }

        // unexport the pins
        if (strcmp(argv[1], "unexport") == 0) {
            unexportPin(MOTOR_FRONT_0);
            unexportPin(MOTOR_FRONT_1);
            unexportPin(MOTOR_BACK_0);
            unexportPin(MOTOR_BACK_1);

            return 0;
        }
    } else {
        // print the help info and exit
        printf("Usage: PiCar [f|b|l|r] [start|stop]\n");
    }

    return 0;
}
