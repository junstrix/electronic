		ORG		0000H
		AJMP	MAIN
		ORG		0030H
MAIN:	MOV		60H,#00H ;01130718
		MOV		61H,#01H
		MOV		62H,#01H
		MOV		63H,#03H
		MOV		64H,#00H
		MOV		65H,#07H
		MOV		66H,#01H
		MOV		67H,#08H

		MOV		R0,#68H
		MOV		R4,#8
		MOV		A,#17  ;68 69 6a 6b 6c 6d 6e 6f
MLP:	MOV		@R0,A
		INC	R0
		DJNZ	R4,MLP

;-------------------------
LOOP:	ACALL	LOTDISP
		ACALL	PROC
		SJMP	LOOP

LOTDISP:MOV		R4,#10	;;delay
LLP:	ACALL	DISPLAY
		DJNZ	R4,LLP
		RET
;--------------------------------------
display:MOV		R7, #8
		MOV		R0,#60H
		MOV		R6,#01H
		MOV		DPTR,#TAB
LOOP3:	MOV		A,@R0	
		MOVC	A,@A+DPTR
		MOV		P2,A
		MOV		P1,R6
		MOV		A,R6
		RL		A
		MOV		R6,A
		ACALL	delay1mS
		MOV		P1,#00H
		INC		R0
		DJNZ	R7,LOOP3
		RET

PROC:	PUSH	00H	;R0H
		PUSH	01H	;R1H
		PUSH	ACC	;A
		MOV		R2,#15
		MOV		R0,#6EH ;0110 1110   
		MOV		R1,#6FH ;0110 1111
		MOV		70H,@R1
			   
;		MOV		R2,#7     ;RIGHT/LEFT
;		MOV		R0,#66H    ;RIGHT
;		MOV		R1,#67H	   ;RIGHT
;		MOV		68H,@R1	   ;RIGHT
;		MOV		R0,#60H	   ;LEFT
;		MOV		R1,#61H	   ;LEFT
;		MOV		68H,@R0	   ;LEFT

PROCPL:	
		;MOV		A,@R0  ;RIGHT
		;MOV		@R1,A  ;RIGHT
;		MOV		A,@R1	   ;LEFT
;		MOV		@R0,A	   ;LEFT
		MOV		A,@R0  
		MOV		@R1,A
		DEC		R0
		DEC		R1  
;		DEC		R0	;RIGHT
;		DEC		R1	;RIGHT
;		INC		R0	;LEFT
;		INC		R1	;LEFT
		DJNZ	R2,PROCPL
;		MOV		60H,68H	  ;RIGHT
;		MOV		67H,68H   ;LEFT
		MOV		60H,70H	  
		POP		ACC
		POP		01H
		POP		00H
		RET	
;��ʱ--------------------------------
delay1mS:MOV	40H,#1
MD0:	 MOV	41H,#10
MD1:	 MOV	42H,#200
		 DJNZ	42H,$
		 DJNZ	41H,MD1
		 DJNZ	40H,MD0
		 RET
delay1S: MOV	45H,#20
MDD0:	 MOV	46H,#10
MDD1:	 MOV	47H,#200
		 DJNZ	47H,$
		 DJNZ	46H,MDD1
		 DJNZ	45H,MDD0
		 RET		 				   
		ORG		0100H
TAB:	DB	0xC0,0xF9,0xA4,0xB0,0x99,0x92,0x82,0xF8,0x80,0x90
		DB	0x88,0x83,0xC6,0xA7,0xA1,0x86,0xBF,0FFH
		END