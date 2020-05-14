DATAS SEGMENT
    ary dw 6,15,8,26,3,22,36,17,33,56
    arysize dw 20
    position dw 0
    table dw 3 dup(?)
    temp dw 0
DATAS ENDS

STACKS SEGMENT
    dw 20 dup(0)
STACKS ENDS

CODES SEGMENT
   
main proc far
	ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    
    mov table,offset ary
    mov table+2,offset arysize
    mov table+4,offset position
    mov bx,offset table
    call com_pary
    
    MOV AH,4CH
    INT 21H
    ret
main endp
com_pary proc near
	push ax
	push cx
	push si
	push di
	
	mov si,[bx]
	mov di,[bx+2]
	mov cx,[di]
	mov di,[bx+4]
loop1:
	push cx
	mov ax,arysize
	sub ax,cx
	mov bp,ax
	mov bx,ds:[si+bp]
	mov di,bp
	
	add bp,2
loop2:
	cmp ds:[si+bp],bx
	jnb continue
	mov bx,ds:[si+bp]
	mov di,bp
continue:
	add bp,2
	cmp bp,arysize
	jbe loop2
	
	mov bp,ax
	mov ax,ds:[si+bp]
	mov dx,bx
	mov bx,di
	mov ds:[si+bx],ax
	mov ds:[si+bp],dx
	
	pop cx
	sub cx,2
	cmp cx,0
	ja loop1
	
	pop di
	pop si
	pop cx
	pop ax
	ret
com_pary endp

CODES ENDS
    END START
