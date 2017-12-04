/**
 * Some stuff I've learned in the last few days but have now realized I can't apply here
 * because apparently the hex-file is "too large" then.. (or far too slow / other stuff)
 * Also, I've deleted a lot of stuff but this is some.
 */
// Developed for ATTiny13A

#include <avr/io.h>
#include <avr/interrupt.h>
#define F_CPU 1000000         // Internal clock at 1MHz
#include <util/delay.h>
#include <math.h>

#define c 256     // Local time unit. c := 256us
#define T 4000    // Period time for fading [c]

volatile int t = 0;    // Elapsed Time [c]; t elem. [0, T[

/**
 * Timer: Interrupt every 256 / 1000000Hz = 256us = 1c
 */
ISR (TIM0_OVF_vect) {
	t = (t + 1) % T;       // Increment `t` by 1c, adjust to be in first period
}

/**
 * Rectangle Wave Function
 * =======================
 * 1 if t < T/2, 0 otherwise.
 *
 * Arguments
 * ---------
 * t: time [c] (elem. [0, T[)
 */
int rect(int t) {
	return t < T/2;
}

int main() {
    DDRB = 0xFF;     // Declare Port B as output
	PORTB = 0x00;    // Turn all LEDs off

	// Initialize timer
	TCCR0B |= (1 << CS00);    // Use clock without prescaling
	TIMSK0 |= (1 << TOIE0);   // Configure ISR
	sei();                    // Start ISR
    TCNT0 = 0;                // Reset timer

	while(1) {
		PORTB ^= (-rect(t) ^ PORTB) & (1 << PB0);
	}
}
