	.file	"ft_strcmp.c"
	.intel_syntax noprefix
	.text
	.globl	ft_strcmp
	.type	ft_strcmp, @function
ft_strcmp:
.LFB0:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-8], rdi
	mov	QWORD PTR [rbp-16], rsi
	mov	rax, QWORD PTR [rbp-8]
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR [rbp-16]
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	je	.L4
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, BYTE PTR [rax]
	movzx	edx, al
	mov	rax, QWORD PTR [rbp-16]
	movzx	eax, BYTE PTR [rax]
	movzx	eax, al
	sub	edx, eax
	mov	eax, edx
	jmp	.L3
.L5:
	mov	rax, QWORD PTR [rbp-8]
	sub	rax, 1
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L4
	mov	eax, 0
	jmp	.L3
.L4:
	mov	rax, QWORD PTR [rbp-8]
	lea	rdx, [rax+1]
	mov	QWORD PTR [rbp-8], rdx
	movzx	ecx, BYTE PTR [rax]
	mov	rax, QWORD PTR [rbp-16]
	lea	rdx, [rax+1]
	mov	QWORD PTR [rbp-16], rdx
	movzx	eax, BYTE PTR [rax]
	cmp	cl, al
	je	.L5
	mov	rax, QWORD PTR [rbp-8]
	sub	rax, 1
	movzx	eax, BYTE PTR [rax]
	movzx	edx, al
	mov	rax, QWORD PTR [rbp-16]
	sub	rax, 1
	movzx	eax, BYTE PTR [rax]
	movzx	eax, al
	sub	edx, eax
	mov	eax, edx
.L3:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	ft_strcmp, .-ft_strcmp
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
