data segment
    array db 12,23,2,4,3,9,8,34,21,44,55,66,77,11,90
    count db $-array ;数组长度
data ends
code segment
	assume cs:code,ds:data
start:       
    mov ax,data
    mov ds,ax

    mov ax,0     
    mov cx,0
	mov cl,count
	dec cx;比较n-1次
	mov bx,0
loop1:
	push cx
	mov si,bx;内循环下标
	mov al,array[si]
loop2:
	cmp al,array[si+1]
	jg next;设为最小值，交换
	jmp done
next:
	xchg al,array[si+1];暂存
done:
	inc si
	loop loop2
	mov array[bx],al;得到一个最小值
	inc bx
	pop cx
	loop loop1	
	mov ax,4c00h
	int 21h
	code ends
	end  start