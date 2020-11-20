	.file	"ft_strdup.c"
	.intel_syntax noprefix
	.text
	.globl	ft_strdup
	.type	ft_strdup, @function
ft_strdup:
.LFB6:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi
	mov	rax, QWORD PTR [rbp-24]
	mov	rdi, rax
	call	ft_strlen
	mov	DWORD PTR [rbp-12], eax
	mov	eax, DWORD PTR [rbp-12]
	add	eax, 1
	cdqe
	mov	rdi, rax
	call	malloc
	mov	QWORD PTR [rbp-8], rax
	cmp	QWORD PTR [rbp-8], 0
	jne	.L2
	mov	eax, 0
	jmp	.L3
.L2:
	mov	eax, DWORD PTR [rbp-12]
	movsx	rdx, eax
	mov	rax, QWORD PTR [rbp-8]
	add	rax, rdx
	mov	BYTE PTR [rax], 0
	mov	DWORD PTR [rbp-16], -1
	jmp	.L4
.L5:
	mov	eax, DWORD PTR [rbp-16]
	movsx	rdx, eax
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-16]
	movsx	rcx, edx
	mov	rdx, QWORD PTR [rbp-8]
	add	rdx, rcx
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR [rdx], al
.L4:
	add	DWORD PTR [rbp-16], 1
	mov	eax, DWORD PTR [rbp-16]
	cmp	eax, DWORD PTR [rbp-12]
	jl	.L5
	mov	rax, QWORD PTR [rbp-8]
.L3:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	ft_strdup, .-ft_strdup
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
