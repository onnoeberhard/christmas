#include <avr/io.h>
#define F_CPU 1000000         // Internal clock at 1MHz
#include <util/delay.h>

int main() {
    DDRB = 0xFF;     // Declare Port B as output
	PORTB = 0x00;    // Turn all LEDs off

	while(1) {
		for (int i = 0; i < 100; i++) {
    PORTB ^= 1 << PB0;
    _delay_ms(0);
    PORTB ^= 1 << PB0;
    _delay_ms(10);
}
for (int i = 0; i < 100; i++) {
    PORTB ^= 1 << PB0;
    _delay_ms(0.000559017);
    PORTB ^= 1 << PB0;
    _delay_ms(9.99944);
}
for (int i = 0; i < 100; i++) {
    PORTB ^= 1 << PB0;
    _delay_ms(0.00316228);
    PORTB ^= 1 << PB0;
    _delay_ms(9.99684);
}
for (int i = 0; i < 100; i++) {
    PORTB ^= 1 << PB0;
    _delay_ms(0.00871421);
    PORTB ^= 1 << PB0;
    _delay_ms(9.99129);
}
for (int i = 0; i < 100; i++) {
    PORTB ^= 1 << PB0;
    _delay_ms(0.0178885);
    PORTB ^= 1 << PB0;
    _delay_ms(9.98211);
}
for (int i = 0; i < 100; i++) {
    PORTB ^= 1 << PB0;
    _delay_ms(0.03125);
    PORTB ^= 1 << PB0;
    _delay_ms(9.96875);
}
for (int i = 0; i < 100; i++) {
    PORTB ^= 1 << PB0;
    _delay_ms(0.049295);
    PORTB ^= 1 << PB0;
    _delay_ms(9.9507);
}
for (int i = 0; i < 100; i++) {
    PORTB ^= 1 << PB0;
    _delay_ms(0.072472);
    PORTB ^= 1 << PB0;
    _delay_ms(9.92753);
}
for (int i = 0; i < 100; i++) {
    PORTB ^= 1 << PB0;
    _delay_ms(0.101193);
    PORTB ^= 1 << PB0;
    _delay_ms(9.89881);
}
for (int i = 0; i < 100; i++) {
    PORTB ^= 1 << PB0;
    _delay_ms(0.135841);
    PORTB ^= 1 << PB0;
    _delay_ms(9.86416);
}
for (int i = 0; i < 100; i++) {
    PORTB ^= 1 << PB0;
    _delay_ms(0.176777);
    PORTB ^= 1 << PB0;
    _delay_ms(9.82322);
}
for (int i = 0; i < 100; i++) {
    PORTB ^= 1 << PB0;
    _delay_ms(0.135841);
    PORTB ^= 1 << PB0;
    _delay_ms(9.86416);
}
for (int i = 0; i < 100; i++) {
    PORTB ^= 1 << PB0;
    _delay_ms(0.101193);
    PORTB ^= 1 << PB0;
    _delay_ms(9.89881);
}
for (int i = 0; i < 100; i++) {
    PORTB ^= 1 << PB0;
    _delay_ms(0.072472);
    PORTB ^= 1 << PB0;
    _delay_ms(9.92753);
}
for (int i = 0; i < 100; i++) {
    PORTB ^= 1 << PB0;
    _delay_ms(0.049295);
    PORTB ^= 1 << PB0;
    _delay_ms(9.9507);
}
for (int i = 0; i < 100; i++) {
    PORTB ^= 1 << PB0;
    _delay_ms(0.03125);
    PORTB ^= 1 << PB0;
    _delay_ms(9.96875);
}
for (int i = 0; i < 100; i++) {
    PORTB ^= 1 << PB0;
    _delay_ms(0.0178885);
    PORTB ^= 1 << PB0;
    _delay_ms(9.98211);
}
for (int i = 0; i < 100; i++) {
    PORTB ^= 1 << PB0;
    _delay_ms(0.00871421);
    PORTB ^= 1 << PB0;
    _delay_ms(9.99129);
}
for (int i = 0; i < 100; i++) {
    PORTB ^= 1 << PB0;
    _delay_ms(0.00316228);
    PORTB ^= 1 << PB0;
    _delay_ms(9.99684);
}
for (int i = 0; i < 100; i++) {
    PORTB ^= 1 << PB0;
    _delay_ms(0.000559017);
    PORTB ^= 1 << PB0;
    _delay_ms(9.99944);
}
	}
}
