; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strcpy.asm                                      :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: ezalos <ezalos@student.42.fr>              +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/11/18 16:25:20 by ezalos            #+#    #+#              ;
;    Updated: 2020/11/18 16:25:32 by ezalos           ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

global ft_strcpy ; C function

; rbp		old value of start stack, 8 octets
; rsp		current stack pointer value
; rcx		scratch register
;			const char *str

; rax		func return value
;			size_t len

; dl		scratch register
;			tmp ->

section .text

ft_strcpy:
    push rbp				; stack += rbp
    mov rbp, rsp			; rbp = rsp

	mov r11, rdi			; str_1 = argument_1
    mov r12, rsi			; str_2 = argument_2

    xor r9, r9				; i = 0;
	dec r9					; i = -1;
	jmp startLoop

endString:
	cmp BYTE[r11 + r9], 0x0		; if (*(str_1 + i) == 0)
	je end						; 	return
	cmp BYTE[r12 + r9], 0x0		; if (*(str_2 + i) == 0)
	je end						; 	return

startLoop:
	xor r15, r15			; tmp = 0
    xor rax, rax			; tmp = 0
	inc r9					; i++;
	mov al, [r11 + r9]		; tmp = *(str_1 + i)
    mov r15b, [r12 + r9]		; tmp = *(str_1 + i)

    sub eax, r15d			; tmp -= *(str_2 + i)
	cmp eax, 0x0				; if (tmp == 0)
    je endString			; 	checkend

end:
	;mov rsp, rbp
    pop rbp

    ret
