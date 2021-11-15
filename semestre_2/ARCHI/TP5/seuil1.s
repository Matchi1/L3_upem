	.file	"seuil.c"
	.text
	.globl	compte_inf_seuil
	.type	compte_inf_seuil, @function
compte_inf_seuil:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movl	$0, -8(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L2
.L4:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	cmpl	%eax, -20(%rbp)
	jle	.L3
	addl	$1, -8(%rbp)
.L3:
	addl	$1, -4(%rbp)
.L2:
	movl	-4(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jl	.L4
	movl	-8(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	compte_inf_seuil, .-compte_inf_seuil
	.globl	random_int
	.type	random_int, @function
random_int:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
.L7:
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
	jge	.L7
	movl	-4(%rbp), %eax
	cltd
	idivl	-20(%rbp)
	movl	%edx, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	random_int, .-random_int
	.section	.rodata
	.align 8
.LC0:
	.string	"nombre de valeur inf\303\251rieure au seuil : %d\n"
.LC2:
	.string	"temps d'ex\303\251cution : %f\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	leaq	-36864(%rsp), %r11
.LPSRL0:
	subq	$4096, %rsp
	orq	$0, (%rsp)
	cmpq	%r11, %rsp
	jne	.LPSRL0
	subq	$3168, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$500, -40028(%rbp)
	movl	$0, -40032(%rbp)
	jmp	.L10
.L11:
	movl	$1001, %edi
	call	random_int
	movl	-40032(%rbp), %edx
	movslq	%edx, %rdx
	movl	%eax, -40016(%rbp,%rdx,4)
	addl	$1, -40032(%rbp)
.L10:
	cmpl	$9999, -40032(%rbp)
	jle	.L11
	call	clock@PLT
	movl	%eax, -40024(%rbp)
	leaq	-40016(%rbp), %rdx
	movl	-40028(%rbp), %eax
	movl	$10000, %esi
	movl	%eax, %edi
	call	compte_inf_seuil
	movl	%eax, %esi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	call	clock@PLT
	movl	%eax, -40020(%rbp)
	movl	-40020(%rbp), %eax
	subl	-40024(%rbp), %eax
	movl	%eax, %eax
	testq	%rax, %rax
	js	.L12
	cvtsi2ssq	%rax, %xmm0
	jmp	.L13
.L12:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	cvtsi2ssq	%rdx, %xmm0
	addss	%xmm0, %xmm0
.L13:
	movss	.LC1(%rip), %xmm1
	divss	%xmm1, %xmm0
	cvtss2sd	%xmm0, %xmm0
	leaq	.LC2(%rip), %rdi
	movl	$1, %eax
	call	printf@PLT
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L15
	call	__stack_chk_fail@PLT
.L15:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	main, .-main
	.section	.rodata
	.align 4
.LC1:
	.long	1232348160
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
