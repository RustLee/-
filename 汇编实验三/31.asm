;将栈中字符取出并输出
PRINT MACRO X
	MOV CX,X
PRI:
	POP AX
	CMP AH,10
	JB NEXT
	ADD AH,7H
NEXT:	
	ADD AH,30H
	MOV DL,AH
	MOV AH,02H
	INT 21H
	LOOP PRI
	ENDM
	
DATAS SEGMENT
	BUFF DB 6     ;定义缓存区的大小为6
	DB ?             
	DB 10 DUP(?)
	INPUT DW 0
    K db 8
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    LEA DX,BUFF      ;加载缓存区首地址                  
    MOV AH,0AH       ;功能号0AH送AH     
    INT 21H                
	MOV CL,BUFF[1]		;获取实际数的位数
	XOR CH,CH
	MOV SI,2
	CALL GET10
	MOV AX,DI
	MOV BX,0
TOK:;通过不断除k的方式得到k进制的各个位数
	DIV K
	PUSH AX
	MOV AH,0
	INC BX
	CMP AX,0
	JNZ TOK
	
	PRINT BX
                                       
    MOV AH,4CH
    INT 21H
    
    
GET10 PROC NEAR;将字符串转成数字
GETIT:    
    MOV BL,BUFF[SI]
	SUB BL,30H
	MOV BH,0
	PUSH BX
	INC SI
	LOOP GETIT
	MOV CL,BUFF[1]
	MOV DI,0
	MOV BX,1
TO10:
    MOV AX,0
	POP AX
	MUL BX
	ADD DI,AX
	MOV AX,BX
	MOV BX,10
	MUL BX
	MOV BX,AX
	LOOP TO10
	RET
GET10 ENDP
CODES ENDS
    END START

