; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strlen.asm                                      :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: ezalos <ezalos@student.42.fr>              +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/11/18 14:51:01 by ezalos            #+#    #+#              ;
;    Updated: 2020/11/19 15:23:43 by ezalos           ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

global ft_strlen ; C function name

section .text

ft_strlen:
    push rbp				; stack += rbp
    mov rbp, rsp			; rbp = rsp

; REPNE SCASB
; RAX:	char to look for
; RDI:	String to perform search on, here it's also our arg_1 (string)
; RCX:	Counter which SCASB will increment (because of instruction CLD)

startLoop:
	MOV     RAX, 0			;Byte to search for (NUL)
	MOV     RCX, -1			;Start count at FFFFh
	CLD						;Increment DI after each character
	REPNE SCASB             ;Scan string for NUL, decrementing CX for each char
	MOV     RAX, -2			;CX will be -2 for length 0, -3 for length 1, ...
	SUB     RAX, RCX		;Length in AX

end:
	mov rsp, rbp
    pop rbp
    ret




ft_strlen_hand:
    push rbp				; stack += rbp
    mov rbp, rsp			; rbp = rsp

    mov rcx, rdi			; str = argument_1

    xor rax, rax			; retval = 0;
	dec rax					; retval = -1;

startLoop_hand:
    xor r8, r8				; tmp = 0
	inc rax					; retval++;
    mov r8, [rcx + rax]		; tmp = *(str +retval)

    cmp r8, 0x0				; if (tmp == 0)
    jne startLoop_hand		; 	continue

end_hand:
	;mov rsp, rbp
    pop rbp

    ret
