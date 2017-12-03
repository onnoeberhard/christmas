.include "tn13adef.inc"

.equ DARK = 0x05
.equ BRIGHT = 0xFF

.equ CYCLES = 1
.equ DT = 16

ldi r16, RAMEND    ; Initialize stack pointer
out SPL, r16

ldi r16, 0xFF      ; Set port B as output
out DDRB, r16
ldi r16, 0xFF      ; Turn off all LEDs
out PORTB, r16

loop:
	ldi r17, DARK
l1:	ldi r18, CYCLES
l2:	cbi PORTB, PB0
    mov r16, r17
    rcall delay
    sbi PORTB, PB0
    ldi r16, 0xFF
    sub r16, r17
    rcall delay
    dec r18
    brne l2
	inc r17
	cpi r17, BRIGHT
    brne l1
l3:	ldi r18,CYCLES
l4:	cbi PORTB, PB0
    mov r16, r17
    rcall delay
    sbi PORTB, PB0
    ldi r16, 0xFF
    sub r16, r17
    rcall delay
    dec r18
    brne l4
    dec r17
    cpi r17, DARK
    brne l3

    rjmp loop


; Delay for R16 * DT steps
delay:
	tst r16
    breq d3
d1:	ldi r24, DT
d2:	dec r24
    brne d2
    dec r16
    brne d1
d3:	ret
