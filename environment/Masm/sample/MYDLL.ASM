;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; �ó�����һ���򵥵Ķ�̬���ӿ�,����ʵ�ֶԶԻ�����
; ��ĳ��ֵ�ļӼ�.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ������: MyDll.asm
; Copyright 2004-3 by zhouwei
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.386 
.model flat,stdcall 
option casemap:none 
;******************include****************************
include 	windows.inc 
include 	user32.inc 
include 	kernel32.inc 
includelib 	user32.lib 
includelib 	kernel32.lib 
;******************data*******************************
.data 
val		dd	?
bRet	dd	?
;******************code******************************
.code 
;================================================================
; ��ں��� 
;================================================================
DllEntry proc hInstDLL:HINSTANCE, reason:DWORD, reserved1:DWORD 
	mov  eax,TRUE 
	ret 
DllEntry Endp 
;================================================================
; ������������������������������������������������� 
;================================================================
AddVal proc hWnd:DWORD, dwID:DWORD
	invoke GetDlgItemInt, hWnd, dwID, NULL, NULL
	inc eax
	invoke SetDlgItemInt, hWnd, dwID, eax, TRUE
    ret 
AddVal endp 
;================================================================
DecVal proc hWnd:DWORD, dwID:DWORD
	invoke GetDlgItemInt, hWnd, dwID, NULL, NULL
	dec eax
	invoke SetDlgItemInt, hWnd, dwID, eax, TRUE
    ret
DecVal endp 

End DllEntry 