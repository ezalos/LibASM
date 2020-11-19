; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strcmp.asm                                      :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: ezalos <ezalos@student.42.fr>              +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/11/18 14:50:57 by ezalos            #+#    #+#              ;
;    Updated: 2020/11/19 16:47:12 by ezalos           ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

extern ft_strlen
global ft_strcmp ; C function

; rbp		old value of start stack, 8 octets
; rsp		current stack pointer value
; rcx		scratch register
;			const char *str

; rax		func return value
;			size_t len

; dl		scratch register
;			tmp ->

section .text

ft_strcmp:
    push rbp				; stack += rbp
    mov rbp, rsp			; rbp = rsp

check_bigger:
	push RDI				; save RDI bc strlen consume it

	call ft_strlen
	mov R10, RAX			; R10 = ft_strlen(str1)

	mov RDI, RSI			; preparge arg strlen = str2
	call ft_strlen
	mov R11, RAX			; R11 = ft_strlen(str2)

	pop RDI					; restore RDI
	mov R9, R10				; R9 = len(str1)
	sub R9, R11				; R9 -= len(str2)
	jna s2_bigger			; if !(R9 > 0) -> s2 else s1

s1_bigger:
	mov R9, R10
	jmp startLoop

s2_bigger:
	mov R9, R11
	jmp startLoop

; REPNE SCASB
; RAX:	char to look for
; RDI:	DST String to perform search on, here it's also our arg_1 (str1)
; RSI:	SRC String to perform search on, here it's also our arg_2 (str2)
; RCX:	Counter which SCASB will increment (because of instruction CLD)

startLoop:
	MOV     RCX, R9			;String length
	CLD						;left to right or auto-increment mode
	REPE CMPSB             	;cmp till equal or cx=0
	xor     rax, rax
	dec     rdi
	dec     rsi
	MOV     al, BYTE[RDI]		;cmp value is not stored, we need to calcul it again
	xor     r9, r9
	MOV     r9b, BYTE[RSI]		;Length in AX
	SUB     rax, r9		;Length in AX

end:
	mov rsp, rbp
    pop rbp
    ret






ft_strcmp_hand:
    push rbp				; stack += rbp
    mov rbp, rsp			; rbp = rsp

	mov r11, rdi			; str_1 = argument_1
    mov r12, rsi			; str_2 = argument_2

    xor r9, r9				; i = 0;
	dec r9					; i = -1;
	jmp startLoop_hand

endString_hand:
	cmp BYTE[r11 + r9], 0x0		; if (*(str_1 + i) == 0)
	je end_hand					; 	return
	cmp BYTE[r12 + r9], 0x0		; if (*(str_2 + i) == 0)
	je end_hand					; 	return

startLoop_hand:
	xor r15, r15			; tmp = 0
    xor rax, rax			; tmp = 0
	inc r9					; i++;
	mov al, [r11 + r9]		; tmp = *(str_1 + i)
    mov r15b, [r12 + r9]	; tmp = *(str_1 + i)

    sub eax, r15d			; tmp -= *(str_2 + i)
	cmp eax, 0x0			; if (tmp == 0)
    je endString_hand		; 	checkend

end_hand:
	mov rsp, rbp
    pop rbp

    ret
