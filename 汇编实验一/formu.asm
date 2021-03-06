DATAS SEGMENT
	X DW 2
	Y DW 8
	Z DW 15
	Shang DW ?
	Yushu DW ?
    ;此处输入数据段代码  
DATAS ENDS

STACKS SEGMENT
	DB 128 DUP(?)
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;此处输入代码段代码

	MOV BX,Y
	MOV CX,8
	MUL BX
	MOV CX,X
	ADD AX,CX
	;求出X+8Y
	MOV BX,Z
	MOV CX,2
	SUB BX,CX
	;求出Z-2
	DIV BX
	;求出（8Y+X）/（Z-2）
	ADD AX,30H
	ADD DX,30H
	;转码
	MOV Shang,AX
	MOV Yushu,DX
	MOV AH,02
	INT 21H
	MOV DX,Shang
	MOV AH,02
	INT 21H
	;调用int 21h功能输出
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START