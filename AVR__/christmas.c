#include <avr/io.h>
#define F_CPU 1000000         // Internal clock at 1MHz
#include <util/delay.h>

int main() {
    DDRB = 0xFF;     // Declare Port B as output
	PORTB = 0x00;    // Turn all LEDs off

	float ds[] = {0.1, 0.5};

	while(1) {
		for (int i = 0; i < 2; i++) {
			float d = ds[i];
			PORTB ^= 1 << PB0;
			_delay_ms(d);
			PORTB ^= 1 << PB0;
			_delay_ms(1 - d);
		}
	}
}
