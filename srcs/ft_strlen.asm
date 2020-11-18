; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strlen.asm                                      :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: ezalos <ezalos@student.42.fr>              +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/11/18 14:51:01 by ezalos            #+#    #+#              ;
;    Updated: 2020/11/18 14:51:02 by ezalos           ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

global ft_strlen ; C function

; rbp		old value of start stack, 8 octets
; rsp		current stack pointer value
; rcx		scratch register
;			const char *str

; rax		func return value
;			size_t len

; dl		scratch register
;			tmp ->

section .text

ft_strlen:
    push rbp				; stack += rbp
    mov rbp, rsp			; rbp = rsp

    mov rcx, rdi			; str = argument_1

    xor rax, rax			; retval = 0;
	dec rax					; retval = -1;

startLoop:
    xor r8, r8				; tmp = 0
	inc rax					; retval++;
    mov r8, [rcx + rax]		; tmp = *(str +retval)

    cmp r8, 0x0				; if (tmp == 0)
    jne startLoop			; 	continue

end:
	;mov rsp, rbp
    pop rbp

    ret
