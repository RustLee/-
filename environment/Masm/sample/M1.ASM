EXTRN   OUTMSG:far			; ˵��M2.asm�е��ӳ���OUTMSG
DATAS   SEGMENT      		
MSG	DB 'Hello  ','$'
DATAS   ENDS

CODES	SEGMENT   		
MAIN	PROC FAR
	ASSUME	CS:CODES,DS:DATAS
START:	push	ds
	mov  	ax,0
	push	ax

	mov  	ax,DATAS
	mov  	ds,ax		     	
	mov  	dx,OFFSET MSG     	
	mov  	ah,09h		     	
	int	    21h		     	

	call	far ptr OUTMSG		; ����M2.asm�е��ӳ���OUTMSG
	ret
MAIN	ENDP
CODES	ENDS
	END START