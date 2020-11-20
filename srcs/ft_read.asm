; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_read.asm                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: ezalos <ezalos@student.42.fr>              +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/11/20 11:54:01 by ezalos            #+#    #+#              ;
;    Updated: 2020/11/20 16:09:40 by ezalos           ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;


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

extern __errno_location

global ft_read ; C function

section .text
ft_read:
    push rbp				; stack += rbp
    mov rbp, rsp			; rbp = rsp
	mov RAX, 0
	syscall
	cmp RAX, 0
	jl error_handle
	jmp byebye

error_handle:
	mov r8,  0
 	sub r8,  RAX
	call __errno_location wrt ..plt
	mov [rax], r8
	mov rax, -1

byebye:
	leave
	ret
