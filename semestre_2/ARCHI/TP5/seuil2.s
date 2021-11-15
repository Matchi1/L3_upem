	.file	"seuil.c"
	.text
	.globl	compte_inf_seuil
	.type	compte_inf_seuil, @function
compte_inf_seuil:
.LFB39:
	.cfi_startproc
	endbr64
	testl	%esi, %esi
	jle	.L5
	movq	%rdx, %rax
	leal	-1(%rsi), %ecx
	leaq	4(%rdx,%rcx,4), %rsi
	movl	$0, %edx
.L4:
	cmpl	%edi, (%rax)
	setl	%cl
	movzbl	%cl, %ecx
	addl	%ecx, %edx
	addq	$4, %rax
	cmpq	%rsi, %rax
	jne	.L4
.L1:
	movl	%edx, %eax
	ret
.L5:
	movl	$0, %edx
	jmp	.L1
	.cfi_endproc
.LFE39:
	.size	compte_inf_seuil, .-compte_inf_seuil
	.globl	random_int
	.type	random_int, @function
random_int:
.LFB40:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movl	%edi, %ebp
	movl	$2147483647, %ebx
.L8:
	call	rand@PLT
	movl	%eax, %ecx
	movl	%ebx, %eax
	cltd
	idivl	%ebp
	movl	%ebx, %eax
	subl	%edx, %eax
	cmpl	%ecx, %eax
	jle	.L8
	movl	%ecx, %eax
	cltd
	idivl	%ebp
	movl	%edx, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE40:
	.size	random_int, .-random_int
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"nombre de valeur inf\303\251rieure au seuil : %d\n"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"temps d'ex\303\251cution : %f\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB41:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	leaq	-36864(%rsp), %r11
	.cfi_def_cfa 11, 36888
.LPSRL0:
	subq	$4096, %rsp
	orq	$0, (%rsp)
	cmpq	%r11, %rsp
	jne	.LPSRL0
	.cfi_def_cfa_register 7
	subq	$3160, %rsp
	.cfi_def_cfa_offset 40048
	movq	%fs:40, %rax
	movq	%rax, 40008(%rsp)
	xorl	%eax, %eax
	movq	%rsp, %rbx
	leaq	40000(%rsp), %rbp
.L12:
	movl	$1001, %edi
	call	random_int
	movl	%eax, (%rbx)
	addq	$4, %rbx
	cmpq	%rbp, %rbx
	jne	.L12
	call	clock@PLT
	movq	%rax, %rbx
	movq	%rsp, %rdx
	movl	$10000, %esi
	movl	$500, %edi
	call	compte_inf_seuil
	movl	%eax, %edx
	leaq	.LC0(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	call	clock@PLT
	subl	%ebx, %eax
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	divss	.LC1(%rip), %xmm0
	cvtss2sd	%xmm0, %xmm0
	leaq	.LC2(%rip), %rsi
	movl	$1, %edi
	movl	$1, %eax
	call	__printf_chk@PLT
	movq	40008(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L18
	movl	$0, %eax
	addq	$40024, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L18:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE41:
	.size	main, .-main
	.section	.rodata.cst4,"aM",@progbits,4
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
