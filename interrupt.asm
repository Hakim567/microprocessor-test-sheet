system_port_a:	EQU	10H
system_port_b:	EQU	11H
system_port_c:	EQU	12H
SYSPORTCTRL:	EQU	13H

		ORG	802CH		; RST 5.5
		JMP	ISR_5_5
		ORG	8034H		; RST 6.5
		JMP	ISR_6_5
		ORG	803CH		; RST 7.5
		JMP	ISR_7_5
		
		ORG	8100hH
		LXI	SP,0F000H
		;JMP	START
		
		
START:		MVI 	A, 00001110B	; set mask 0001 1110
					;	   b6-b7 ->00 is for SOD/SOE - not relevant                                
					;          b5    ->n/c
					;          b4    ->1 R7.5 is ENABLE R7.5
					;          b3    ->1 Mask setting enabled
					;          b2    ->0 M7.5 is enabled
					;          b1    ->1 M6.5 is Masked
					;          b0    ->0 M5.5 is enabled
		SIM    			;Set interrupt masking
		EI			;Enable interrupt

LOOPHERE:
		MVI	A,0FH
		OUT	0
		CALL	DLY
		CMA
		OUT	0
		CALL	DLY
		JMP	LOOPHERE
		HLT

DLY:		MVI	C,0A0H
INL:		MVI	B,0FFH
DLY1:		DCR	B
		JNZ	DLY1
		DCR 	C
		JNZ	INL
		RET

ISR_5_5:	
		MVI	E, 05H
R5:             MVI	A, 05H
		OUT	0
		CALL DLY
		MVI	A, 0
		OUT	0
		CALL	DLY
		DCR	E
		JNZ	R5
		EI
		RET

ISR_6_5:	MVI	E, 06H
R6:		MVI	A,06H
		OUT	0
		CALL 	DLY
		MVI	A, 0
		OUT	0
		CALL 	DLY
		DCR	E
		JNZ	R6
		EI
		RET

ISR_7_5:	MVI	A,07H
		OUT	0
		CALL DLY
		MVI	A, 0
		OUT	0
		MVI	A,07H
		OUT	0
		CALL DLY
		MVI	A, 0
		OUT	0
		EI
		RET