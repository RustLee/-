datas segment
    buff db 100,0,100 dup(0)  ;数据缓存�?
    outrec db 10 dup(0)     ;存放筛选后结果
    turns dw 0              ;记录字母个数
    file_name db 'output1.txt',00H     ;文件�?
    create_err db 0DH,0AH,'ERROR:Fail to create file!','$'   ;创建文件错误
    open_err db 0DH,0AH,'ERROR:Fail to open	file!','$'   ;打开文件错误
    write_err db 0DH,0AH,'ERROR:Fail to write file!','$'     ;写文件错�?
    close_err db 0DH,0AH,'ERROR:Fail to close file!','$'     ;关闭文件错误
    whandle dw ?            ;保存文件句柄
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
    
	lea dx,buff
	mov ah,0ah
	int 21h	
	
	mov al,buff[1]
	mov bx,0
	mov bp,0
comp:
	cmp bl,al
	jz save
	cmp buff[bx+2],'a'
	jb fai
	cmp buff[bx+2],'z'
	jna suc
	cmp buff[bx+2],'A'
	jb fai
	cmp buff[bx+2],'Z'
	jna suc
	jmp fai
	
suc:
	inc turns
	mov ah,buff[bx+2]
	mov outrec[bp],ah
	inc bp
fai:
	inc bx
	jmp comp
	
save:
	mov ah,3ch
	mov cx,0
	lea dx,file_name
	int 21h
	jc error1
	mov ah,3dh
	mov al,1
	lea dx,file_name
	int 21h
	jc error2
	mov whandle,ax
	mov ah,40h
	mov bx,whandle
	mov cx,turns
	lea dx,outrec
	int 21h
	jc error3
	mov ah,3eh
	mov bx,whandle
	int 21h
	jc error4
	jmp exit
	
error1:
	LEA DX , create_err
	MOV AH , 9
	INT 21H
	jmp exit
	
error2:
	LEA DX , open_err
	MOV AH , 9
	INT 21H
	jmp exit
	
error3:
	LEA DX , write_err
	MOV AH , 9
	INT 21H
	jmp exit
	
error4:
	LEA DX , close_err
	MOV AH , 9
	INT 21H
	jmp exit
	
	
exit:
    mov ah,4ch
    int 21h

codes ends


