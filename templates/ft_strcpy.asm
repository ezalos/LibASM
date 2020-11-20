	.file	"ft_strcpy.c"
	.intel_syntax noprefix
	.text
	.globl	ft_strcpy
	.type	ft_strcpy, @function
ft_strcpy:
.LFB0:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-24], rdi
	mov	QWORD PTR [rbp-32], rsi
	mov	DWORD PTR [rbp-4], -1
	jmp	.L2
.L3:
	mov	eax, DWORD PTR [rbp-4]
	movsx	rdx, eax
	mov	rax, QWORD PTR [rbp-32]
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-4]
	movsx	rcx, edx
	mov	rdx, QWORD PTR [rbp-24]
	add	rdx, rcx
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR [rdx], al
.L2:
	add	DWORD PTR [rbp-4], 1
	mov	eax, DWORD PTR [rbp-4]
	movsx	rdx, eax
	mov	rax, QWORD PTR [rbp-32]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L3
	mov	eax, DWORD PTR [rbp-4]
	movsx	rdx, eax
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rdx
	mov	BYTE PTR [rax], 0
	mov	rax, QWORD PTR [rbp-24]
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	ft_strcpy, .-ft_strcpy
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
