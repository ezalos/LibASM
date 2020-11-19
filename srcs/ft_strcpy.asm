; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strcpy.asm                                      :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: ezalos <ezalos@student.42.fr>              +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/11/18 16:25:20 by ezalos            #+#    #+#              ;
;    Updated: 2020/11/18 18:04:44 by ezalos           ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

; Valid data for registers. It's different for windows

; REGISTERS
; Byt 8 7 6 5     4 3         2      1
; RAX[_ _ _ _ EAX[_ _ AX [AH [_] AL [_]]]]			Func return value
; RBX         EBX     BX  BH     BL					/!\ used in indexed addressing
; RCX         ECX     CX  CH     CL					Scratch ~ loop count in iterative operations ~ Arg4
; RDX         EDX     DX  DH     DL					Scratch ~ Arg3
; RSI         ESI     SI         SIL				Scratch ~ src index String Ope ~ Arg2
; RDI         EDI     DI         DIL				Scratch ~ dst index String Ope ~ Arg1
; RBP         EBP     BP         BPL				/!\ Old RSP (Stack Pointer)
; RSP         ESP     SP         SPL				/!\ Stack Pointer (SS:SP)
; RIP         EIP     IP							Instruction Pointer
;
; Byt 8 7 6 5     4 3         2      1
; R8 [_ _ _ _ R8D[_ _ R8W[    _  R8B[_]]]]			Scratch ~ Arg5
; R9												Scratch ~ Arg6
; R10												Scratch
; R11												Scratch
; R12												/!\ ??
; R13												/!\ ??
; R14												/!\ ??
; R15												/!\ ??
;
; Byt 8 7 6 5     4 3         2      1
;
; The 16-bit IP register stores the offset address of the next instruction
; to be executed.
; IP in association with the CS register (as CS:IP) gives the complete address
; of the current instruction in the code segment.



; SEGMENTS
;
;
; CS		Code Segment	Instructions are always fetched from here
; DS		Data Segment	Any stack push or pop or any data reference referring to the stack
; SS		Stack Segment	All other references to data
; ES		Extra Segment	default destination for string operations (for example MOVS or CMPS)
; FS
; GS



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
