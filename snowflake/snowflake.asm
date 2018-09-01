.include "tn13adef.inc"

.equ DT = 0xF
.equ CYCLES = 3
.equ PERIOD = 0xFF
.equ BRIGHT = 0xFF
.equ MIDDLE = 0x80
.equ DARK = 0x00

.equ LEDS = PORTB    ; PORTB: LEDs
.equ L0 = PB0        ; PB0: LED 0
.equ L1 = PB1        ; PB1: LED 1
.equ L2 = PB2        ; PB2: LED 2
.equ L3 = PB3        ; PB3: LED 3

.def temp = r16      ; R16: Temp register
.def time = r17      ; R17: Delay time register
.def count = r18     ; R18: Number of remaining repetitions for each brightness
.def B0 = r19        ; R19: Brightness (delay) for L0
.def B1 = r20        ; R20: Brightness (delay) for L1
.def B2 = r21        ; R21: Brightness (delay) for L2
.def B3 = r22        ; R22: Brightness (delay) for L3

ldi temp, RAMEND     ; Initialize stack pointer
out SPL, temp

ldi temp, 0xFF    ; Set port B as output
out DDRB, temp
ldi temp, 0x00    ; Turn off all LEDs
out PORTB, temp

ldi B0, DARK         ; Initialize L0 brightness to DARK
ldi B1, MIDDLE       ; Initialize L1 brightness to MIDDLE (-1/4 phase shift)
ldi B2, BRIGHT       ; Initialize L2 brightness to BRIGHT (-1/2 phase shift)
ldi B3, MIDDLE       ; Initialize L3 brightness to MIDDLE (-3/4 phase shift)

loop:
A:  ldi count, CYCLES    ; Reset cycles
A_: sbi LEDS, L0         ; Light L0
    sbi LEDS, L1         ; Light L1
    sbi LEDS, L2         ; Light L2
    sbi LEDS, L3         ; Light L3
    mov time, B0         ; Delay for the shortest time (B0)
    rcall delay
    cbi LEDS, L0         ; Extinguish L0
    mov time, B3         ; Delay for the next shortest time (B3 - B0)
    sub time, B0
    rcall delay
    cbi LEDS, L3         ; Extinguish L3
    mov time, B1         ; Delay for the next shortest time (B1 - B3)
    sub time, B3
    rcall delay
    cbi LEDS, L1         ; Extinguish L1
    mov time, B2         ; Delay for the next shortest time (B2 - B1)
    sub time, B1
    rcall delay
    cbi LEDS, L2         ; Extinguish L2
    ldi time, PERIOD     ; Delay for the remaining time (PERIOD - B2)
    sub time, B2
    rcall delay
    dec count            ; One cycle has passed
    brne A_              ; Repeat same brightness if there are still cycles
    inc B0               ; Increment the brightness for L0
    inc B1               ; Increment the brightness for L1
    dec B2               ; Decrement the brightness for L2
    dec B3               ; Decrement the brightness for L3
    cp B0, B3            ; Repeat if L0 is still darker than L3
    brlo A
    cp B1, B2            ; Repeat if L1 is still darker than L2
    brlo A
B:  ldi count, CYCLES    ; Reset cycles
B_: sbi LEDS, L0         ; Light L0
    sbi LEDS, L1         ; Light L1
    sbi LEDS, L2         ; Light L2
    sbi LEDS, L3         ; Light L3
    mov time, B3         ; Delay for the shortest time (B3)
    rcall delay
    cbi LEDS, L3         ; Extinguish L3
    mov time, B0         ; Delay for the next shortest time (B0 - B3)
    sub time, B3
    rcall delay
    cbi LEDS, L0         ; Extinguish L0
    mov time, B2         ; Delay for the next shortest time (B2 - B0)
    sub time, B0
    rcall delay
    cbi LEDS, L2         ; Extinguish L2
    mov time, B1         ; Delay for the next shortest time (B1 - B2)
    sub time, B2
    rcall delay
    cbi LEDS, L1         ; Extinguish L1
    ldi time, PERIOD     ; Delay for the remaining time (PERIOD - B1)
    sub time, B1
    rcall delay
    dec count            ; One cycle has passed
    brne B_              ; Repeat same brightness if there are still cycles
    inc B0               ; Increment the brightness for L0
    ldi temp, BRIGHT     ; Increment the brightness for L1 if not already BRIGHT
    cpse B1, temp
    inc B1
    dec B2               ; Decrement the brightness for L2
    ldi temp, DARK       ; Decrement the brightness for L3 if not already DARK
    cpse B3, temp
    dec B3
    cp B0, B2            ; Repeat if L0 is still darker than L2
    brlo B
C:  ldi count, CYCLES    ; Reset cycles
C_: sbi LEDS, L0         ; Light L0
    sbi LEDS, L1         ; Light L1
    sbi LEDS, L2         ; Light L2
    sbi LEDS, L3         ; Light L3
    mov time, B3         ; Delay for the shortest time (B3)
    rcall delay
    cbi LEDS, L3         ; Extinguish L3
    mov time, B2         ; Delay for the next shortest time (B2 - B3)
    sub time, B3
    rcall delay
    cbi LEDS, L2         ; Extinguish L2
    mov time, B0         ; Delay for the next shortest time (B0 - B2)
    sub time, B2
    rcall delay
    cbi LEDS, L0         ; Extinguish L0
    mov time, B1         ; Delay for the next shortest time (B1 - B0)
    sub time, B0
    rcall delay
    cbi LEDS, L1         ; Extinguish L1
    ldi time, PERIOD     ; Delay for the remaining time (PERIOD - B1)
    sub time, B1
    rcall delay
    dec count            ; One cycle has passed
    brne C_              ; Repeat same brightness if there are still cycles
    inc B0               ; Increment the brightness for L0
    dec B1               ; Decrement the brightness for L1
    dec B2               ; Decrement the brightness for L2
    inc B3               ; Increment the brightness for L3
    cp B0, B1            ; Repeat if L0 is still darker than L1
    brlo C
    cp B3, B2            ; Repeat if L3 is still darker than L2
    brlo C
D:  ldi count, CYCLES    ; Reset cycles
D_: sbi LEDS, L0         ; Light L0
    sbi LEDS, L1         ; Light L1
    sbi LEDS, L2         ; Light L2
    sbi LEDS, L3         ; Light L3
    mov time, B2         ; Delay for the shortest time (B2)
    rcall delay
    cbi LEDS, L2         ; Extinguish L2
    mov time, B3         ; Delay for the next shortest time (B3 - B2)
    sub time, B2
    rcall delay
    cbi LEDS, L3         ; Extinguish L3
    mov time, B1         ; Delay for the next shortest time (B1 - B3)
    sub time, B3
    rcall delay
    cbi LEDS, L1         ; Extinguish L1
    mov time, B0         ; Delay for the next shortest time (B0 - B1)
    sub time, B1
    rcall delay
    cbi LEDS, L0         ; Extinguish L0
    ldi time, PERIOD     ; Delay for the remaining time (PERIOD - B0)
    sub time, B0
    rcall delay
    dec count            ; One cycle has passed
    brne D_              ; Repeat same brightness if there are still cycles
    ldi temp, BRIGHT     ; Increment the brightness for L0 if not already BRIGHT
    cpse B0, temp
    inc B0
    dec B1               ; Decrement the brightness for L1
    ldi temp, DARK       ; Decrement the brightness for L2 if not already DARK
    cpse B2, temp
    dec B2
    inc B3               ; Increment the brightness for L3
    cp B3, B1            ; Repeat if L3 is still darker than L1
    brlo D
E:  ldi count, CYCLES    ; Reset cycles
E_: sbi LEDS, L0         ; Light L0
    sbi LEDS, L1         ; Light L1
    sbi LEDS, L2         ; Light L2
    sbi LEDS, L3         ; Light L3
    mov time, B2         ; Delay for the shortest time (B2)
    rcall delay
    cbi LEDS, L2         ; Extinguish L2
    mov time, B1         ; Delay for the next shortest time (B1 - B2)
    sub time, B2
    rcall delay
    cbi LEDS, L1         ; Extinguish L1
    mov time, B3         ; Delay for the next shortest time (B3 - B1)
    sub time, B1
    rcall delay
    cbi LEDS, L3         ; Extinguish L3
    mov time, B0         ; Delay for the next shortest time (B0 - B3)
    sub time, B3
    rcall delay
    cbi LEDS, L0         ; Extinguish L0
    ldi time, PERIOD     ; Delay for the remaining time (PERIOD - B0)
    sub time, B0
    rcall delay
    dec count            ; One cycle has passed
    brne E_              ; Repeat same brightness if there are still cycles
    dec B0               ; Decrement the brightness for L0
    dec B1               ; Decrement the brightness for L1
    inc B2               ; Increment the brightness for L2
    inc B3               ; Increment the brightness for L3
    cp B3, B0            ; Repeat if L3 is still darker than L0
    brlo E
    cp B2, B1            ; Repeat if L2 is still darker than L1
    brlo E
F:  ldi count, CYCLES    ; Reset cycles
F_: sbi LEDS, L0         ; Light L0
    sbi LEDS, L1         ; Light L1
    sbi LEDS, L2         ; Light L2
    sbi LEDS, L3         ; Light L3
    mov time, B1         ; Delay for the shortest time (B1)
    rcall delay
    cbi LEDS, L1         ; Extinguish L1
    mov time, B2         ; Delay for the next shortest time (B2 - B1)
    sub time, B1
    rcall delay
    cbi LEDS, L2         ; Extinguish L2
    mov time, B0         ; Delay for the next shortest time (B0 - B2)
    sub time, B2
    rcall delay
    cbi LEDS, L0         ; Extinguish L0
    mov time, B3         ; Delay for the next shortest time (B3 - B0)
    sub time, B0
    rcall delay
    cbi LEDS, L3         ; Extinguish L3
    ldi time, PERIOD     ; Delay for the remaining time (PERIOD - B3)
    sub time, B3
    rcall delay
    dec count            ; One cycle has passed
    brne F_              ; Repeat same brightness if there are still cycles
    dec B0               ; Decrement the brightness for L0
    ldi temp, DARK       ; Decrement the brightness for L1 if not already DARK
    cpse B1, temp
    dec B1
    inc B2               ; Increment the brightness for L2
    ldi temp, BRIGHT     ; Increment the brightness for L3 if not already BRIGHT
    cpse B3, temp
    inc B3
    cp B2, B0            ; Repeat if L2 is still darker than L0
    brlo F
G:  ldi count, CYCLES    ; Reset cycles
G_: sbi LEDS, L0         ; Light L0
    sbi LEDS, L1         ; Light L1
    sbi LEDS, L2         ; Light L2
    sbi LEDS, L3         ; Light L3
    mov time, B1         ; Delay for the shortest time (B1)
    rcall delay
    cbi LEDS, L1         ; Extinguish L1
    mov time, B0         ; Delay for the next shortest time (B0 - B1)
    sub time, B1
    rcall delay
    cbi LEDS, L0         ; Extinguish L0
    mov time, B2         ; Delay for the next shortest time (B2 - B0)
    sub time, B0
    rcall delay
    cbi LEDS, L2         ; Extinguish L2
    mov time, B3         ; Delay for the next shortest time (B3 - B2)
    sub time, B2
    rcall delay
    cbi LEDS, L3         ; Extinguish L3
    ldi time, PERIOD     ; Delay for the remaining time (PERIOD - B3)
    sub time, B3
    rcall delay
    dec count            ; One cycle has passed
    brne G_              ; Repeat same brightness if there are still cycles
    dec B0               ; Decrement the brightness for L0
    inc B1               ; Increment the brightness for L1
    inc B2               ; Increment the brightness for L2
    dec B3               ; Decrement the brightness for L3
    cp B1, B0            ; Repeat if L1 is still darker than L0
    brlo G
    cp B2, B3            ; Repeat if L2 is still darker than L3
    brlo G
H:  ldi count, CYCLES    ; Reset cycles
H_: sbi LEDS, L0         ; Light L0
    sbi LEDS, L1         ; Light L1
    sbi LEDS, L2         ; Light L2
    sbi LEDS, L3         ; Light L3
    mov time, B0         ; Delay for the shortest time (B0)
    rcall delay
    cbi LEDS, L0         ; Extinguish L0
    mov time, B1         ; Delay for the next shortest time (B3 - B0)
    sub time, B0
    rcall delay
    cbi LEDS, L1         ; Extinguish L1
    mov time, B3         ; Delay for the next shortest time (B3 - B1)
    sub time, B1
    rcall delay
    cbi LEDS, L3         ; Extinguish L3
    mov time, B2         ; Delay for the next shortest time (B2 - B3)
    sub time, B3
    rcall delay
    cbi LEDS, L2         ; Extinguish L2
    ldi time, PERIOD     ; Delay for the remaining time (PERIOD - B2)
    sub time, B2
    rcall delay
    dec count            ; One cycle has passed
    brne H_              ; Repeat same brightness if there are still cycles
    ldi temp, DARK       ; Decrement the brightness for L0 if not already DARK
    cpse B0, temp
    dec B0
    inc B1               ; Increment the brightness for L1
    ldi temp, BRIGHT     ; Increment the brightness for L2 if not already BRIGHT
    cpse B2, temp
    inc B2
    dec B3               ; Decrement the brightness for L3
    cp B1, B3            ; Repeat if L1 is still darker than L3
    brlo H

    rjmp loop


; Delay for `time` * `DT` steps
delay:
    tst time
    breq d3
d1: ldi temp, DT
d2: dec temp
    brne d2
    dec time
    brne d1
d3: ret
