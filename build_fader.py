n = 10
for i in range(n):
    print(fr"""for (int i = 0; i < 100; i++) {{
    PORTB ^= 1 << PB0;
    _delay_ms({(i/n/2)**2.5:g});
    PORTB ^= 1 << PB0;
    _delay_ms({10 - (i/n/2)**2.5:g});
}}""")
for i in range(n):
    print(fr"""for (int i = 0; i < 100; i++) {{
    PORTB ^= 1 << PB0;
    _delay_ms({((n-i)/n/2)**2.5:g});
    PORTB ^= 1 << PB0;
    _delay_ms({10 - ((n-i)/n/2)**2.5:g});
}}""")
