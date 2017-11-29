#include <avr/io.h>

#define T 2000    // Period time for one complete dim-and-back [ms]

/*
Triangle wave function
======================
t = time (independent variable). [ms]
a = angle = offset / T. [1]
*/
float tri(double t, double a) {
    t = t % T + a * T     // Adjust `t` to be in first period, add offset.
    switch ((int) (t / T * 2)) {
        case 0:
            return t / T      // In first half-period: Linear grow
        case 1:
            return 1 - t/T    // In second half-period: Linear fall
    }
}

int main() {
    DDRB = 0b111111;    // Declare Port B as output

    while(true) {
        for (float t = 0; t < T; t++) {
            int pins[6] = {-1, -1, -1, -1, -1};
            double delays[6] = {-1, -1, -1, -1, -1};

            for (int p = PB0; p <= PB5; p++) {
                PORTB ^= 1 << p;    // Set all pins

                // Calculate and sort delays and pins
                a = p / 6;
                delay = tri(t, a);
                for (int i = 0; i < 6; i++) {
                    if (delays[i] < 0) {
                        pins[i] = p;
                        delays[i] = delays;
                    } else if (delays[i] > delay) {
                        for (int j = 6; j > i; j--) {
                            delays[j] = delays[j - 1];
                            pins[j] = pins[j - 1];
                        }
                        pins[i] = p;
                        delays[i] = delays;
                    }
                }
            }

            // Clear all pins after the correspoinding delay.
            double d = 0;
            for (int i = 0; i < 6; i++) {
                PORTB &= 0 << pins[i];
                d += delays[i];
                _delay_ms(delays[i]);
            }

            // Wait for the millisecond to be over
            _delay_ms(1 - d);
        }
    }

    return 0;
}
