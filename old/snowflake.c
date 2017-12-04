#include <avr/io.h>

#define T 2000    // Period time for one complete dim-and-back [ms]

/*
Triangle wave function
======================
t = time (independent variable). [ms]
a = angle = offset / T. [1]
*/
double tri(double t, double a) {
    t = (int) t % T + a * T;                                 // Adjust `t` to be in first period, add offset.
    return (int) (t / T * 2) ? 2 - 2 * t / T : 2 * t / T;    // First half-period: linear grow, second: linear fall
}

int main() {
    DDRB = 0b111111;    // Declare Port B as output
    double t = 0;       // Elapsed time [ms]

    while(true) {
        int pins[6] = {-1, -1, -1, -1, -1};
        double delays[6] = {-1, -1, -1, -1, -1};

        for (int p = PB0; p <= PB5; p++) {
            PORTB ^= 1 << p;    // Set all pins

            // Calculate and sort delays and pins
            double a = p / 6;
            double delay = tri(t, a);
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

        // Clear all pins after the corresponding delay.
        double d = 0;
        for (int i = 0; i < 6; i++) {
            PORTB &= 0 << pins[i];
            d += delays[i];
            _delay_ms(delays[i]);
        }

        // Wait for the millisecond to be over (and increment `t` by one)
        _delay_ms(1 - d);
        t++;
    }

    return 0;
}
