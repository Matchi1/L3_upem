	.file	"exo5.c"
	.text
	.globl	random_int
	.type	random_int, @function
random_int:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
.L2:
	call	rand@PLT
	movl	%eax, -4(%rbp)
	movl	$2147483647, %eax
	cltd
	idivl	-20(%rbp)
	movl	%edx, %eax
	movl	$2147483647, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	cmpl	%eax, -4(%rbp)
	jge	.L2
	movl	-4(%rbp), %eax
	cltd
	idivl	-20(%rbp)
	movl	%edx, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	random_int, .-random_int
	.globl	fone
	.type	fone, @function
fone:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movl	$0, -8(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L5
.L7:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	cmpl	$5, %eax
	jle	.L6
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	cmpl	$94, %eax
	jg	.L6
	addl	$1, -8(%rbp)
.L6:
	addl	$1, -4(%rbp)
.L5:
	movl	-4(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jl	.L7
	movl	-8(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	fone, .-fone
	.globl	ftwo
	.type	ftwo, @function
ftwo:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movl	$0, -8(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L10
.L12:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	cmpl	$5, %eax
	jle	.L11
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	cmpl	$94, %eax
	jg	.L11
	addl	$1, -8(%rbp)
.L11:
	addl	$1, -4(%rbp)
.L10:
	movl	-4(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jl	.L12
	movl	-8(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	ftwo, .-ftwo
	.globl	main
	.type	main, @function
main:
.LFB9:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	leaq	-3997696(%rsp), %r11
.LPSRL0:
	subq	$4096, %rsp
	orq	$0, (%rsp)
	cmpq	%r11, %rsp
	jne	.LPSRL0
	subq	$2336, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$200, -4000020(%rbp)
	movl	$0, -4000028(%rbp)
	jmp	.L15
.L16:
	movl	$101, %edi
	call	random_int
	movl	-4000028(%rbp), %edx
	movslq	%edx, %rdx
	movl	%eax, -4000016(%rbp,%rdx,4)
	addl	$1, -4000028(%rbp)
.L15:
	cmpl	$999999, -4000028(%rbp)
	jle	.L16
	movl	$0, -4000024(%rbp)
	movl	$0, -4000028(%rbp)
	jmp	.L17
.L19:
	movl	-4000028(%rbp), %eax
	cltq
	movl	-4000016(%rbp,%rax,4), %eax
	cmpl	$5, %eax
	jle	.L18
	movl	-4000028(%rbp), %eax
	cltq
	movl	-4000016(%rbp,%rax,4), %eax
	cmpl	$94, %eax
	jg	.L18
	addl	$1, -4000024(%rbp)
.L18:
	addl	$1, -4000028(%rbp)
.L17:
	cmpl	$999999, -4000028(%rbp)
	jle	.L19
	movl	$0, -4000024(%rbp)
	movl	$0, -4000028(%rbp)
	jmp	.L20
.L22:
	movl	-4000028(%rbp), %eax
	cltq
	movl	-4000016(%rbp,%rax,4), %eax
	cmpl	$5, %eax
	jle	.L21
	movl	-4000028(%rbp), %eax
	cltq
	movl	-4000016(%rbp,%rax,4), %eax
	cmpl	$94, %eax
	jg	.L21
	addl	$1, -4000024(%rbp)
.L21:
	addl	$1, -4000028(%rbp)
.L20:
	cmpl	$999999, -4000028(%rbp)
	jle	.L22
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L24
	call	__stack_chk_fail@PLT
.L24:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	main, .-main
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
