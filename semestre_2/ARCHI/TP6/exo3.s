	.file	"exo3.c"
	.text
	.p2align 4
	.globl	sum2
	.type	sum2, @function
sum2:
.LFB23:
	.cfi_startproc
	endbr64
	testl	%edi, %edi
	jle	.L7
	leal	-1(%rdi), %eax
	movl	%eax, %ecx
	shrl	$2, %ecx
	addl	$1, %ecx
	cmpl	$15, %eax
	jbe	.L8
	movl	%ecx, %edx
	movdqa	.LC0(%rip), %xmm2
	xorl	%eax, %eax
	pxor	%xmm0, %xmm0
	movdqa	.LC1(%rip), %xmm7
	movdqa	.LC2(%rip), %xmm6
	shrl	$2, %edx
	movdqa	.LC3(%rip), %xmm5
	movdqa	.LC4(%rip), %xmm4
	.p2align 4,,10
	.p2align 3
.L4:
	movdqa	%xmm2, %xmm1
	addl	$1, %eax
	paddd	%xmm7, %xmm2
	movdqa	%xmm1, %xmm3
	paddd	%xmm1, %xmm0
	paddd	%xmm6, %xmm3
	paddd	%xmm3, %xmm0
	movdqa	%xmm1, %xmm3
	paddd	%xmm4, %xmm1
	paddd	%xmm5, %xmm3
	paddd	%xmm3, %xmm0
	paddd	%xmm1, %xmm0
	cmpl	%edx, %eax
	jne	.L4
	movdqa	%xmm0, %xmm1
	movl	%ecx, %esi
	psrldq	$8, %xmm1
	andl	$-4, %esi
	paddd	%xmm1, %xmm0
	leal	0(,%rsi,4), %edx
	movdqa	%xmm0, %xmm1
	psrldq	$4, %xmm1
	paddd	%xmm1, %xmm0
	movd	%xmm0, %eax
	cmpl	%esi, %ecx
	je	.L11
.L3:
	leal	4(%rdx), %ecx
	leal	6(%rax,%rdx,4), %eax
	cmpl	%ecx, %edi
	jle	.L1
	addl	%ecx, %eax
	leal	8(%rdx), %ecx
	leal	11(%rax,%rdx,2), %eax
	leal	7(%rdx,%rax), %eax
	cmpl	%ecx, %edi
	jle	.L1
	addl	%ecx, %eax
	leal	12(%rdx), %ecx
	leal	19(%rax,%rdx,2), %eax
	leal	11(%rdx,%rax), %eax
	cmpl	%ecx, %edi
	jle	.L1
	addl	%ecx, %eax
	leal	27(%rax,%rdx,2), %eax
	leal	15(%rax,%rdx), %eax
	ret
	.p2align 4,,10
	.p2align 3
.L7:
	xorl	%eax, %eax
.L1:
	ret
	.p2align 4,,10
	.p2align 3
.L11:
	ret
.L8:
	xorl	%edx, %edx
	xorl	%eax, %eax
	jmp	.L3
	.cfi_endproc
.LFE23:
	.size	sum2, .-sum2
	.p2align 4
	.globl	sum3
	.type	sum3, @function
sum3:
.LFB24:
	.cfi_startproc
	endbr64
	testl	%edi, %edi
	jle	.L18
	leal	-1(%rdi), %eax
	movl	%eax, %ecx
	shrl	$2, %ecx
	addl	$1, %ecx
	cmpl	$15, %eax
	jbe	.L19
	movl	%ecx, %edx
	movdqa	.LC0(%rip), %xmm3
	xorl	%eax, %eax
	pxor	%xmm2, %xmm2
	movdqa	.LC1(%rip), %xmm8
	movdqa	.LC2(%rip), %xmm7
	shrl	$2, %edx
	movdqa	.LC3(%rip), %xmm6
	movdqa	.LC4(%rip), %xmm5
	.p2align 4,,10
	.p2align 3
.L15:
	movdqa	%xmm3, %xmm1
	addl	$1, %eax
	paddd	%xmm8, %xmm3
	movdqa	%xmm1, %xmm0
	movdqa	%xmm1, %xmm4
	paddd	%xmm7, %xmm0
	paddd	%xmm6, %xmm4
	paddd	%xmm1, %xmm0
	paddd	%xmm5, %xmm1
	paddd	%xmm4, %xmm0
	paddd	%xmm1, %xmm0
	paddd	%xmm0, %xmm2
	cmpl	%edx, %eax
	jne	.L15
	movdqa	%xmm2, %xmm0
	movl	%ecx, %esi
	psrldq	$8, %xmm0
	andl	$-4, %esi
	paddd	%xmm0, %xmm2
	leal	0(,%rsi,4), %edx
	movdqa	%xmm2, %xmm0
	psrldq	$4, %xmm0
	paddd	%xmm0, %xmm2
	movd	%xmm2, %eax
	cmpl	%esi, %ecx
	je	.L21
.L14:
	leal	4(%rdx), %ecx
	leal	6(%rax,%rdx,4), %eax
	cmpl	%ecx, %edi
	jle	.L12
	leal	11(%rcx,%rdx,2), %ecx
	leal	7(%rdx,%rcx), %ecx
	addl	%ecx, %eax
	leal	8(%rdx), %ecx
	cmpl	%ecx, %edi
	jle	.L12
	leal	19(%rcx,%rdx,2), %ecx
	leal	11(%rdx,%rcx), %ecx
	addl	%ecx, %eax
	leal	12(%rdx), %ecx
	cmpl	%ecx, %edi
	jle	.L12
	leal	27(%rcx,%rdx,2), %ecx
	leal	15(%rdx,%rcx), %edx
	addl	%edx, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L18:
	xorl	%eax, %eax
.L12:
	ret
	.p2align 4,,10
	.p2align 3
.L21:
	ret
.L19:
	xorl	%edx, %edx
	xorl	%eax, %eax
	jmp	.L14
	.cfi_endproc
.LFE24:
	.size	sum3, .-sum3
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.long	0
	.long	4
	.long	8
	.long	12
	.align 16
.LC1:
	.long	16
	.long	16
	.long	16
	.long	16
	.align 16
.LC2:
	.long	1
	.long	1
	.long	1
	.long	1
	.align 16
.LC3:
	.long	2
	.long	2
	.long	2
	.long	2
	.align 16
.LC4:
	.long	3
	.long	3
	.long	3
	.long	3
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
