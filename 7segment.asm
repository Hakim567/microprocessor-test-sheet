
		ORG 8100H
		LXI SP, OFFFOH
SYSPORTA: 	EQU 10H
SYSPORTB:	EQU 11H
SYSPORTC:	EQU 12H
SYSPORTCTRL:	EQU 13H
sevseg: 
		MVI A, 90H ;set Port A as input, Port B and C as output
		OUT SYSPORTCTRL
SCAN1:		MVI B, 00H
		MVI C, 0FFH
SCANDISP:
MVI
A, 5
ORI
OFOH
OUT
SYSPORTC
LXI
H, DATA7SEG
; DATA OF 7SEG DIGIT COUNT
;FILTER OUT HIGH NIBBLES TO ENSURE ALL VALUES EQUAL 1 (USE AS INP)
; 10WER NIBBLE DATA IS USED TO SELECT 7 SEG DIGIT
; INITIATE STARTING ADDRESS OF 7 SEG DATA TABLE
MOV
A, B
ADD
L
;
MOV
L, A
MOV
A, M
OUT
CALL
DELAY
ORA
A
SYSPORTB
;
;
; DISPLAY THE SELECTED DIGIT
; STABILIZATION DELAY
; ZEROING ACC
OUT
SYSPORTB
; CLEAR THE DISPLAY
CALL
DELAY
DCR
?
JNZ
SCANDISP
INR
B
MOV
A, B
;
CPI
10
JZ
SCAN1
JMP
SCANDISP
; INCREMENT 7 SEG DIGIT COUNT
;IF COUNT LESS THAN 6, CONTINUE OTHERWISE START ALL OVER ; START NEW SCAN
; CONTINUE TO NEXT DIGIT
DELAY:
LXI
D,
????
DL1:
DCR
D
JNZ
DL1
RET

	ORG 0E000H
	DATA7SEG: DFB 3fh, 06h, 5bh, 4fh, 66h, 6dh, 7dh, 07h, 7fh, 6fh, 77h, 7ch, 39h, 5eh, 79h, 71h