.include "tn13adef.inc"

.equ DT = 0xF
.equ CYCLES = 1
.equ PERIOD = 0xFF
.equ BRIGHT = 0xF0
.equ MIDDLE = 0x78
.equ DARK = 0x00

.equ LEDS = PORTB    ; PORTB: LEDs
.equ L0 = PB0        ; PB0: LED 0
.equ L1 = PB1        ; PB1: LED 1

.def temp = r16      ; R16: Temp register
.def time = r17      ; R17: Delay time register
.def count = r18     ; R18: Number of remaining repetitions for each brightness
.def B0 = r19        ; R19: Brightness (delay) for L0
.def B1 = r20        ; R20: Brightness (delay) for L1

ldi temp, RAMEND     ; Initialize stack pointer
out SPL, temp

ldi temp, 0xFF       ; Set port B as output
out DDRB, temp
ldi temp, 0xFF       ; Turn off all LEDs
out PORTB, temp

ldi B0, DARK         ; Initialize L0 brightness to DARK
ldi B1, MIDDLE       ; Initialize L1 brightness to MIDDLE (-1/4 phase shift)

loop:
A:	ldi count, CYCLES    ; Reset cycles
B:	cbi LEDS, L0     	 ; Light L0
	cbi LEDS, L1         ; Light L1
    mov time, B0         ; Delay for the shortest time (B0)
    rcall delay
    sbi LEDS, L0         ; Extinguish L0
	mov time, B1         ; Delay for the second shortest time (B1 - B0)
	sub time, B0
	rcall delay
	sbi LEDS, L1         ; Extinguish L1
    ldi time, PERIOD     ; Delay for the remaining time (PERIOD - B1)
    sub time, B1
    rcall delay
    dec count            ; One cycle has passed
    brne B               ; Repeat same brightness if there are still cycles
	inc B0               ; Increment the brightness for L0
	inc B1               ; Increment the brightness for L1
	cpi B1, BRIGHT       ; Repeat if L1 has not reached full brightness.
    brne A
C:  ldi count, CYCLES    ; Reset cycles
D:	cbi LEDS, L0         ; Light L0
	cbi LEDS, L1         ; Light L1
    mov time, B0         ; Delay for the shortest time (B0)
    rcall delay
    sbi LEDS, L0         ; Extinguish L0
	mov time, B1         ; Delay for the second shortest time (B1 - B0)
	sub time, B0
	rcall delay
	sbi LEDS, L1         ; Extinguish L1
    ldi time, PERIOD     ; Delay for the remaining time (PERIOD - B1)
    sub time, B1
    rcall delay
    dec count            ; One cycle has passed
    brne D               ; Repeat same brightness if there are still cycles
	inc B0               ; Increment the brightness for L0
	dec B1               ; Increment the brightness for L1
	cp B0, B1            ; Repeat if B1 is still greater than B0
    brlo C
E:  ldi count, CYCLES    ; Reset cycles
F:	cbi LEDS, L0         ; Light PB0
	cbi LEDS, L1         ; Light PB1
    mov time, B1         ; Delay for the shortest time (B1)
    rcall delay
    sbi LEDS, L1         ; Extinguish L1
	mov time, B0         ; Delay for the second shortest time (B0 - B1)
	sub time, B1
	rcall delay
	sbi LEDS, L0         ; Extinguish L0
    ldi time, PERIOD     ; Delay for the remaining time (PERIOD - B0)
    sub time, B0
    rcall delay
    dec count            ; One cycle has passed
    brne F               ; Repeat same brightness if there are still cycles
	inc B0               ; Increment the brightness for L0
	dec B1               ; Increment the brightness for L1
	cpi B0, BRIGHT       ; Repeat if L0 has not reached full brightness.
    brne E
G:  ldi count, CYCLES    ; Reset cycles
H:	cbi LEDS, L0         ; Light PB0
	cbi LEDS, L1         ; Light PB1
    mov time, B1         ; Delay for the shortest time (B1)
    rcall delay
    sbi LEDS, L1         ; Extinguish L1
	mov time, B0         ; Delay for the second shortest time (B0 - B1)
	sub time, B1
	rcall delay
	sbi LEDS, L0         ; Extinguish L0
    ldi time, PERIOD     ; Delay for the remaining time (PERIOD - B0)
    sub time, B0
    rcall delay
    dec count            ; One cycle has passed
    brne H               ; Repeat same brightness if there are still cycles
	dec B0               ; Increment the brightness for L0
	dec B1               ; Increment the brightness for L1
	cpi B1, DARK         ; Repeat if L0 has not reached full brightness.
    brne G
I:  ldi count, CYCLES    ; Reset cycles
J:	cbi LEDS, L0         ; Light PB0
	cbi LEDS, L1         ; Light PB1
    mov time, B1         ; Delay for the shortest time (B1)
    rcall delay
    sbi LEDS, L1         ; Extinguish L1
	mov time, B0         ; Delay for the second shortest time (B0 - B1)
	sub time, B1
	rcall delay
	sbi LEDS, L0         ; Extinguish L0
    ldi time, PERIOD     ; Delay for the remaining time (PERIOD - B0)
    sub time, B0
    rcall delay
    dec count            ; One cycle has passed
    brne J               ; Repeat same brightness if there are still cycles
	dec B0               ; Increment the brightness for L0
	inc B1               ; Increment the brightness for L1
	cp B1, B0            ; Repeat if B0 is still greater than B1
    brlo I
K:  ldi count, CYCLES    ; Reset cycles
L:	cbi LEDS, L0         ; Light PB0
	cbi LEDS, L1         ; Light PB1
    mov time, B0         ; Delay for the shortest time (B0)
    rcall delay
    sbi LEDS, L0         ; Extinguish L0
	mov time, B1         ; Delay for the second shortest time (B1 - B0)
	sub time, B0
	rcall delay
	sbi LEDS, L1         ; Extinguish L1
    ldi time, PERIOD     ; Delay for the remaining time (PERIOD - B1)
    sub time, B1
    rcall delay
    dec count            ; One cycle has passed
    brne L               ; Repeat same brightness if there are still cycles
	dec B0               ; Increment the brightness for L0
	inc B1               ; Increment the brightness for L1
	cpi B0, DARK         ; Repeat if B0 is still greater than B1
    brne K

	rjmp loop


; Delay for `time` * `DT` steps
delay:
	tst time
    breq d3
d1:	ldi r24, DT
d2:	dec r24
    brne d2
    dec time
    brne d1
d3:	ret
