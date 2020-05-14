data segment
	str_all db 'fgraabcaababahf','$'
	sub_str db 'ab','$'
	count db 0
data ends
stack segment stack 
	db 100 dup(?)
stack ends
code segment
assume cs:code,ds:data,ss:stack
start:
	mov ax,data
	mov ds,ax
	lea si,str_all
again:
	lea si,sub_str
	push si
comp0:
	mov al,[si]
	mov bl,[di]
	cmp al,bl
	jnz neq
equ1:
	inc si
	cmp byte ptr [si],'$'
	jnz next
	inc di
	cmp byte ptr [di],'$'
	jnz exit
	add count,1
	jmp exit
next:
	inc di 
	cmp byte ptr [di],'$'
	jnz comp0
	add count,1
	pop si
	inc si
	jmp again
neq:
	pop si
	inc si 
	cmp byte ptr [si],'$'
	jz exit
	jmp again
exit:
	mov ah,4ch
	int 21h
code ends
	end start 


