assume cs:code,ds:data
data segment
	string db 'abc#1L0*9012~\/<>jky6932','$'
	numbers db 0
	words db 0
	others db 0
data ends

code segment
start:
	mov ax,data
	mov ds,ax
	mov si,0
s:
	mov al,string[si]
	cmp al,'$'
	je ok
	cmp al,'0'
	jb sother
	cmp al,'9'
	ja another
	mov bl,numbers
	inc bl
	mov numbers,bl
	inc si
	jmp s	
another:
	cmp al,'A'
	jb sother
	cmp al,'Z'
	ja ananother
	mov bl,words
	inc bl
	mov words,bl
	inc si
	jmp s
ananother:
	cmp al,'a'
	jb sother
	cmp al,'z'
	ja sother
	mov bl,words
	inc bl
	mov words,bl
	inc si
	jmp s
sother:
	mov bl,others
	inc bl
	mov others,bl
	inc si
	jmp s
ok:
	mov ax,4c00h
	int 21h
code ends
end start