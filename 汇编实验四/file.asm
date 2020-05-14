datas segment
    buff db 100,0,100 dup(0)  ;数据缓存区
    outrec db 10 dup(0)     ;存放筛选后结果
    turns dw 0              ;记录字母个数
    file_name db 'output1.txt',00h     ;文件名
    create_err db 0dh,0ah,'error:fail to create file!','$'   ;创建文件错误
    open_err db 0dh,0ah,'error:fail to open	file!','$'   ;打开文件错误
    write_err db 0dh,0ah,'error:fail to write file!','$'     ;写文件错误
    close_err db 0dh,0ah,'error:fail to close file!','$'     ;关闭文件错误
    whandle dw ?            ;保存文件句柄
datas ends
stack segment
    dw 32 dup(?)
stack ends
codes segment
    assume cs:codes,ds:datas,ss:stack
main proc near
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
	cmp buff[bx+2],'a'
	jb fai
	cmp buff[bx+2],'z'
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
	lea dx , create_err
	mov ah , 9
	int 21h
	jmp exit
	
error2:
	lea dx , open_err
	mov ah , 9
	int 21h
	jmp exit
	
error3:
	lea dx , write_err
	mov ah , 9
	int 21h
	jmp exit
	
error4:
	lea dx , close_err
	mov ah , 9
	int 21h
	jmp exit
	
	
exit:
    mov ah,4ch
    int 21h
main endp

codes ends
end start
