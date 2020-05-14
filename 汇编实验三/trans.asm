;将栈中字符取出并输出
print macro x
	mov cx,x
pri:
	pop ax
	cmp ah,10
	jb next
	add ah,7h
next:
	add ah,30h
	mov dl,ah
	mov ah,02h
	int 21h

	loop pri
	endm
	
datas segment
	buff db 6     ;定义缓存区的大小
	db ?             
	db 20 dup(?)
	input dw 0
    k db 16
datas ends

stacks segment
    ;此处输入堆栈段代码
stacks ends

codes segment
    assume cs:codes,ds:datas,ss:stacks
start:
    mov ax,datas
    mov ds,ax
    lea dx,buff      ;加载缓存区首地址                  
    mov ah,0ah       ;功能0ah送ah     
    int 21h                
	mov cl,buff[1]		;获取实际数的位数
	xor ch,ch
	mov si,2
	call get10
	mov ax,di
	mov bx,0
tok:;通过不断除k的方式得到k进制的各个位
	div k 
	push ax
	mov ah,0
	inc bx
	cmp ax,0
	jnz tok
	print bx
    mov ah,4ch
    int 21h
    
    
get10 proc near;将字符串转成数字
getit:    
    mov bl,buff[si]
	sub bl,30h
	mov bh,0
	push bx
	inc si
	loop getit
	mov cl,buff[1]
	mov di,0
	mov bx,1
to10:
    mov ax,0
	pop ax
	mul bx
	add di,ax
	mov ax,bx
	mov bx,10
	mul bx
	mov bx,ax
	loop to10
	ret
get10 endp
codes ends
    end start


