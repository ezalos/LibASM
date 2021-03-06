; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strdup.asm                                      :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: ezalos <ezalos@student.42.fr>              +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/11/19 14:56:31 by ezalos            #+#    #+#              ;
;    Updated: 2020/11/20 16:16:40 by ezalos           ###   ########.fr        ;
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


extern ft_strcpy
extern ft_strlen
extern __errno_location
extern malloc
extern free

global ft_strdup ; C function
global ft_free

;segreg:[base+index*scale+disp]
section .text

ft_free:
    push rbp				; stack += rbp
    mov rbp, rsp			; rbp = rsp

	push RDI
	call free wrt ..plt
	pop RDI

	mov rsp, rbp
	pop rbp

	ret

; ft_malloc:
; 	mov edi, 40; malloc's first (and only) parameter: number of bytes to allocate
; 	extern malloc
; 	call malloc
; 	; on return, rax points to our newly-allocated memory
; 	mov ecx,7; set up a constant
; 	mov [rax],ecx; write it into memory
; 	mov edx,[rax]; read it back from memory
; 	mov eax,edx; copy into return value register
; 	ret

ft_strdup:
    push rbp				; stack += rbp
    mov rbp, rsp			; rbp = rsp

	push RDI

	call ft_strlen

	mov RDI, RAX

	call malloc wrt ..plt
	pop RSI

	cmp RAX, 0
	jl error_handle
	mov RDI, RAX

	push RSI

	call ft_strcpy
	pop RAX
	jmp end

error_handle:
	mov r8,  0
	sub r8,  RAX
	call __errno_location wrt ..plt
	mov [rax], r8
	mov rax, -1

end:
	mov rsp, rbp
    pop rbp

    ret
