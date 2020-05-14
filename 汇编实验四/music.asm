datas segment
    mus_freq  dw 262,294,330,262,262,294,330,262      ;mus_freq数组存放的是乐谱,每一个数表示一个音符
              dw 330,349,392,330,349,392,392,440
              dw 392,349,330,262,392,440,392,349
              dw 330,262,294,196,262,294,196,262
    mus_time  dw 2500,2500,2500,2500,2500,2500,2500,2500,2500,2500    ;mus_freq中对应音符持续时间
              dw 5000,2500,2500,5000,1200,1200,1200,1200,2500,2500
              dw 1200,1200,1200,1200,2500,2500,2500,2500,5000,2500,2500,5000
    mes       db 31h,32h,33h,31h,31h,32h,33h,31h,33h,34h,35h,33h,34h,35h,35h,36h      ;乐谱的数字表示
              db 35h,34h,33h,31h,35h,36h,35h,34h,33h,31h,32h,35h,31h,32h,35h,31h,'$'

datas ends
stack segment
    dw 32 dup(?)
stack ends
codes segment
    assume cs:codes,ds:datas,ss:stack

start:
    mov ax,datas
    mov ds,ax
    mov ax,stack
    mov ss,ax
    mov sp,40h
    
	mov bp,0
	mov si,0
	in al,61h
	and al,0fch
loops:
	cmp mes[bp],'$'
	jz exit
	mov dl,mes[bp]
	mov ah,2
	int 21h
	
	mov al,0b6h
	out 43h,al
	mov di,mus_freq[bp+si]
	mov dx,12h
	mov ax,348ch
	div di
	out 42h,al
	mov al,ah
	out 42h,al
	in al,61h
	mov ah,al
	or al,3
	out 61h,al

	call del

	inc bp
	inc si
	dec dx
	mov al,ah
	out 61h,al
	jne loops
		
exit:
    mov ah,4ch
    int 21h

del proc near
    push ax
    push bx
    push cx
    push dx

	mov bx,500
wait1:
	mov cx,mus_time[bp+si]
delay:
	loop delay
	dec bx
	jnz wait1
    
    pop dx
    pop cx
    pop bx
    pop ax
    
    ret
del endp
codes ends
end start
