datas segment
	w dw 10
	h dw 6
	turns dw 30
	start_x dw 20
	start_y dw 20
datas ends

stack segment stack
	dw 32 dup(?)
stack ends

code segment
	assume cs:code,ds:datas,ss:stack
main proc near
start:
	mov ax,datas
	mov ds,ax
	mov ax,stack
	mov ss,ax
	mov sp,40h
	mov ah,0
	mov al,4
	int 10h
	mov cx,turns
loops:
	call hor_ver
	mov ah,0
	int 16h
	loop loops
	mov ah,0
	mov al,3
	int 10h
    mov ah,4ch
    int 21h
main endp
hor_ver proc near
	push ax
	push bx
	push cx
	push dx
	mov cx,w
li:
	push cx
	mov cx,start_x
	mov dx,start_y
	mov al,1
	mov ah,0ch
	int 10h
	inc start_x
	pop cx
	loop li	
	mov cx,h
ld:
	push cx
	mov cx,start_x
	mov dx,start_y
	mov al,1
	mov ah,0ch
	int 10h
	inc start_y
	pop cx
	loop ld	
	pop dx
	pop cx
	pop bx
	pop ax
	ret
hor_ver endp
code ends
end start


