assume cs:code,ds:data
data segment
	msg1 db 13,10,'please input the num of fibonacci,no lager than 256,n= $'
	msg2 db 13,10,'fibonacci sequence is: $'    ;提示信息

	n dw 0  
	f1  dw 0  
	f2  dw 1  
data ends

code segment
start:
	mov ax,data
	mov ds,ax  
	lea dx,msg1
	mov ah,9
	int 21h    
	call input 
	cmp cx,1    
	jb exit     
	mov n,cx     

	lea dx,msg2  
	mov ah,9  
	int 21h
	mov dl,'1'  
	mov ah,2
	int 21h
	mov dl,' '
	int 21h     
	dec n        
	jz exit     

loop0:
	mov ax,f1  
	add ax,f2  
	jc exit    
	mov bx,f2  
	mov f1,bx  
	mov f2,ax   
	call output
	mov dl,' '  
	mov ah,2
	int 21h    
	dec n      
	jnz loop0  
 
exit:
	mov ah,4ch
	int 21h

input:
	mov bl,10
	mov cx,0 

in_x:      

	mov ah,7
	int 21h   

	cmp al,13 
	je in_end  

	cmp al,'0'
	jb in_x
	cmp al,'9'
	ja in_x  

	mov dl,al   

	mov ah,2  
	int 21h
	mov al,dl   
	sub al,30h  
	mov ah,0                           
	xchg ax,cx  
	mul bl       
	add cx,ax   
	cmp ch,0 
	jnz in_end
	jmp in_x  

in_end:
	ret   
output:
	mov bx,10 
	mov cx,0  
     

loop1:
	mov dx,0
	div bx       
	add dl,'0'   
	push dx
	inc cx 
	cmp ax,0     
	jnz loop1
	mov ah,2
loop2:
	pop dx
	int 21h
	loop loop2
	ret         
code ends
	end start