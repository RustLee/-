PUBLIC	OUTMSG
DATAS   SEGMENT      		
   MSG	DB 'World!',13,10,'$'
DATAS   ENDS

CODES	SEGMENT   			

OUTMSG	PROC FAR
	ASSUME	CS:CODES,DS:DATAS
START:	
	mov  	ax,DATAS
	mov  	ds,ax		     	
	mov  	dx,OFFSET MSG     	
	mov  	ah,09h		     	
	int	21h		     	; ��ʾMSG,���Ϊ"World!"
	ret
OUTMSG	ENDP
CODES	ENDS
	END START