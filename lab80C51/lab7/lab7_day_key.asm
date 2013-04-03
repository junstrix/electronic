	; 70H 71H 72H 资源已经使用
	ORG 0000H
	AJMP MAIN
	ORG 000BH
	AJMP INTT0
	ORG 0030H
MAIN:
	SETB EA
	SETB ET0
	SETB TR0
	
	MOV TMOD,#01H
	MOV TL0,#0AEH
	MOV TH0,#3CH

	MOV 60H,#00H
	MOV 61H,#00H
	MOV 62H,#00H
	MOV 63H,#00H
	MOV 64H,#00H
	MOV 65H,#00H
	MOV 66H,#00H
	MOV 67H,#00H
	
	MOV P1,#00H
	MOV 70H,#20 ; delay
	
LOOP:
	ACALL DISPLAY

	JB P3.2,KEY3
	ACALL DISPLAY
	ACALL DISPLAY
	JB P3.2,KEY3
	ACALL MINKEY
KEY3:
	JB P3.3,LOOP
	ACALL DISPLAY
	ACALL DISPLAY
	JB P3.3,LOOP
	ACALL HOURKEY
	
	SJMP LOOP
	
DISPLAY:

	MOV R3,#8
	MOV R0,#67H
	MOV R4,#80H
	MOV DPTR,#TAB
LOOP1:
	MOV A,@R0
	MOVC A,@A+DPTR
	MOV P2,A
	MOV P1,R4
	
	MOV A,R4
	RR A
	MOV R4,A
	
	ACALL DELAY
	MOV P1,#00H
	DEC R0
	DJNZ R3,LOOP1
	RET

INTT0:

	MOV TL0,#0AEH
	MOV TH0,#3CH
	DJNZ 70H,EXITT0
	MOV 70H,#20
	
	ACALL CONLED	
EXITT0:
	RETI
	
CONLED:
	INC 67H
	MOV A,67H
	CJNE A,#10,EXRET
	MOV 67H,#00H
	
	INC 66H
	MOV A,66H
	CJNE A,#6,EXRET
	MOV 66H,#00H
MINKEY:	;当按键按下，调分钟
	INC 65H
	MOV A,65H
	CJNE A,#10,EXRET
	MOV 65H,#00H
	
	INC 64H
	MOV A,64H
	CJNE A,#6,EXRET
	MOV 64H,#00H
	
HOURKEY:   ;当按键按下，调小时
	INC 63H
	MOV A,63H
	
	CJNE A,#4,CONE0 ;判断是否等于24 小时的 4 ,
	MOV A,62H
	CJNE A,#2,CONE0 ;如果60H等于2且61H等于4，则顺序执行复位
	SJMP HOURS24
	
CONE0:
	MOV A,63H
	CJNE A,#10,EXRET
	MOV 63H,#00H
	
	INC 62H
	MOV A,62H
	SJMP EXRET
HOURS24:  ;;;; Label HOURKE~HOURS24 为处理24小时进位问题
	;; 24 hours Reset
	MOV 62H,#00H
	MOV 63H,#00H
	MOV 64H,#00H
	MOV 65H,#00H
	MOV 66H,#00H
	MOV 67H,#00H
	
	INC 61H
	MOV A,61H
	CJNE A,#10,EXRET
	
	INC 60H
	MOV A,60H
	CJNE A,#10,EXRET
	; 99 day Reset
	MOV 60H,#00H
	MOV 61H,#00H
	MOV 62H,#00H
	MOV 63H,#00H
	MOV 64H,#00H
	MOV 65H,#00H
	MOV 66H,#00H
	MOV 67H,#00H
EXRET:
	RET
DELAY: ; delay 1ms
	MOV 71H,#7 ; 7*8 = 56ms
DL0:	
	MOV 72,#0FAH ; 250*4 
DL1:
	NOP
	NOP
	DJNZ 72,DL1
	DJNZ 71H,DL0
	RET
TAB:
	DB      0C0H, 0F9H, 0A4H, 0B0H  ;0, 1, 2, 3
	DB       99H,  92H,  82H, 0F8H  ;4, 5, 6, 7
	DB       80H,  90H;,  0BFH		;8, 9, -
	END