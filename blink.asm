.NOLIST
.INCLUDE "m8Adef.inc"
.LIST

.CSEG
SBI DDRB, PINB0 ;Set B0 to output

; Initialize SP
ldi	r16,LOW(RAMEND)		; load low byte of RAMEND into r16
out	SPL,r16		        ; store r16 in stack pointer low
ldi	r16,HIGH(RAMEND)	; load high byte of RAMEND into r16
out	SPH,r16		        ; store r16 in stack pointer high
loop:
  CBI PORTB, PINB0        ; clear bit 0 of port B
  RCALL delay
  SBI PORTB, PINB0        ; set bit 0 of port B
  RCALL delay
  RJMP loop
delay:
  PUSH r26
  PUSH r27
  PUSH r28
  LDI r26, 8
delay1:
  LDI r27, 125
delay2:
  LDI r28, 250
delay3:
  DEC r28
  NOP
  BRNE delay3
  DEC r27
  BRNE delay2
  DEC r26
  BRNE delay1
  POP r28
  POP r27
  POP r26
  RET
