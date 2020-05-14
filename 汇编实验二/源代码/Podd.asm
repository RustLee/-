data Segment
number dw 24,13,-5,7,-101,28,46,77,100,3
result dw ?
data ends
stacks segment
	stack dw 100 dup(?)
stacks ends
program Segment
main proc far
assume ds:data,cs:program,ss:stacks
s:
	mov ax,data
	mov ds,ax
	mov ax,stacks
	mov ss,ax
	mov bx,0

start:
	cmp bx,20
	jz begin
	cmp number[bx],0
	jng X
	test number[bx],01h
	jz X
	mov ax,number[bx]
	add result,ax
X:
	add bx,2
	jmp start
begin:
	mov bx,10
	mov ax,result
	mov cx,1
	
	call print
	ret
main endp

print proc near
divs:
	mov dx,0
	div bx
	push dx
	cmp ax,0
	jz show
	inc	cx
	jmp divs
show:
	pop dx
	add dl,30h
	mov ah,2
	int 21h
	loop show
print endp
 
exit:    
    mov ax, 4c00h
    int 21h

program ends
end s
