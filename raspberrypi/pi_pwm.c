/*raspberry pi PWM Control*/
/*compile: gcc led.c -lwiringPi -lpthread*/
#include <stdlib.h>
#include <wiringPi.h>
#define PIN 1 /* setup GPIO 17 */
int main(int argc, const char *argv[])
{
	int l;
	if (wiringPiSetup() == -1) {
		exit(1);
	}
	pinMode(PIN,OUTPUT);
	digitalWrite(PIN,LOW);
	pinMode(PIN,PWM_OUTPUT);
	while (1) {
		for (l = 0; l < 1024; l++) {
			pwmWrite(PIN,l);
			delay(1);
		}
		for (l = 1023; l >= 0; l--) {
			pwmWrite(PIN,l);
			delay(1);
		}
	}
	return 0;
}
