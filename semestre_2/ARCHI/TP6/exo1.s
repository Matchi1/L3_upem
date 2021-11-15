	.file	"exo1.c"
	.text
	.p2align 4
	.globl	sum0
	.type	sum0, @function
sum0:
.LFB40:
	.cfi_startproc
	endbr64
	testl	%edi, %edi
	jle	.L8
	leal	-1(%rdi), %eax
	cmpl	$17, %eax
	jbe	.L9
	movl	%edi, %edx
	movdqa	.LC0(%rip), %xmm1
	xorl	%eax, %eax
	pxor	%xmm0, %xmm0
	movdqa	.LC1(%rip), %xmm3
	shrl	$2, %edx
	.p2align 4,,10
	.p2align 3
.L4:
	movdqa	%xmm1, %xmm2
	addl	$1, %eax
	paddd	%xmm3, %xmm1
	paddd	%xmm2, %xmm0
	cmpl	%edx, %eax
	jne	.L4
	movdqa	%xmm0, %xmm1
	movl	%edi, %edx
	psrldq	$8, %xmm1
	andl	$-4, %edx
	paddd	%xmm1, %xmm0
	movdqa	%xmm0, %xmm1
	psrldq	$4, %xmm1
	paddd	%xmm1, %xmm0
	movd	%xmm0, %eax
	testb	$3, %dil
	je	.L13
	.p2align 4,,10
	.p2align 3
.L7:
	addl	%edx, %eax
	addl	$1, %edx
	cmpl	%edx, %edi
	jg	.L7
	ret
	.p2align 4,,10
	.p2align 3
.L13:
	ret
	.p2align 4,,10
	.p2align 3
.L8:
	xorl	%eax, %eax
	ret
.L9:
	xorl	%eax, %eax
	xorl	%edx, %edx
	jmp	.L7
	.cfi_endproc
.LFE40:
	.size	sum0, .-sum0
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC3:
	.string	"n=%d : %.10f sec\n"
	.text
	.p2align 4
	.globl	print_timing
	.type	print_timing, @function
print_timing:
.LFB39:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movl	%edi, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	call	clock@PLT
	movl	%r12d, %edi
	movq	%rax, %rbx
	call	*%rbp
	call	clock@PLT
	pxor	%xmm0, %xmm0
	movl	%r12d, %edx
	leaq	.LC3(%rip), %rsi
	subl	%ebx, %eax
	movl	$1, %edi
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	cvtsi2ssq	%rax, %xmm0
	popq	%r12
	.cfi_def_cfa_offset 8
	movl	$1, %eax
	divss	.LC2(%rip), %xmm0
	cvtss2sd	%xmm0, %xmm0
	jmp	__printf_chk@PLT
	.cfi_endproc
.LFE39:
	.size	print_timing, .-print_timing
	.p2align 4
	.globl	sum1
	.type	sum1, @function
sum1:
.LFB41:
	.cfi_startproc
	endbr64
	testl	%edi, %edi
	jle	.L24
	leal	-1(%rdi), %edx
	movl	$9, %eax
	cmpl	$9, %edx
	cmovg	%eax, %edx
	leal	1(%rdx), %esi
	cmpl	$9, %edi
	jle	.L25
	movl	%esi, %ecx
	movdqa	.LC0(%rip), %xmm1
	xorl	%eax, %eax
	pxor	%xmm0, %xmm0
	movdqa	.LC1(%rip), %xmm3
	shrl	$2, %ecx
	.p2align 4,,10
	.p2align 3
.L21:
	movdqa	%xmm1, %xmm2
	addl	$1, %eax
	paddd	%xmm3, %xmm1
	paddd	%xmm2, %xmm0
	cmpl	%ecx, %eax
	jne	.L21
	movdqa	%xmm0, %xmm1
	movl	%esi, %ecx
	psrldq	$8, %xmm1
	andl	$-4, %ecx
	andl	$3, %esi
	paddd	%xmm1, %xmm0
	movdqa	%xmm0, %xmm1
	psrldq	$4, %xmm1
	paddd	%xmm1, %xmm0
	movd	%xmm0, %eax
	je	.L27
.L20:
	leal	1(%rcx), %esi
	addl	%ecx, %eax
	cmpl	%edx, %esi
	jg	.L18
	addl	%esi, %eax
	leal	2(%rcx), %esi
	cmpl	%esi, %edx
	jl	.L18
	addl	%esi, %eax
	leal	3(%rcx), %esi
	cmpl	%esi, %edx
	jl	.L18
	addl	%esi, %eax
	leal	4(%rcx), %esi
	cmpl	%esi, %edx
	jl	.L18
	addl	%esi, %eax
	leal	5(%rcx), %esi
	cmpl	%esi, %edx
	jl	.L18
	addl	%esi, %eax
	leal	6(%rcx), %esi
	cmpl	%esi, %edx
	jl	.L18
	addl	%esi, %eax
	leal	7(%rcx), %esi
	cmpl	%esi, %edx
	jl	.L18
	addl	%esi, %eax
	addl	$8, %ecx
	leal	(%rax,%rcx), %esi
	cmpl	%ecx, %edx
	cmovge	%esi, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L24:
	xorl	%eax, %eax
.L18:
	ret
	.p2align 4,,10
	.p2align 3
.L27:
	ret
.L25:
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	jmp	.L20
	.cfi_endproc
.LFE41:
	.size	sum1, .-sum1
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB42:
	.cfi_startproc
	endbr64
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	leaq	sum0(%rip), %rsi
	movl	$400, %edi
	call	print_timing
	xorl	%eax, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE42:
	.size	main, .-main
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.long	0
	.long	1
	.long	2
	.long	3
	.align 16
.LC1:
	.long	4
	.long	4
	.long	4
	.long	4
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC2:
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
