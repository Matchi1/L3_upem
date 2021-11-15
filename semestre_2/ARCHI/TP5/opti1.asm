	.file	"exo4.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB23:
	.cfi_startproc
	endbr64
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$0, %r9d
	movl	$0, %r8d
	movl	$0, %esi
	movl	$0, %ecx
	movl	$1, %edi
.L2:
	movl	%edi, %eax
	imull	%edi, %eax
	imull	%eax, %eax
	addl	%eax, %ecx
	movl	%ecx, %eax
	imull	%ecx, %eax
	movl	%eax, %edx
	imull	%ecx, %edx
	imull	%ecx, %edx
	addl	%edx, %esi
	imull	%esi, %eax
	imull	%esi, %eax
	addl	%eax, %r8d
	movl	%ecx, %eax
	cltd
	idivl	%esi
	addl	%r9d, %eax
	leal	(%r8,%rax), %r9d
	addl	$1, %edi
	cmpl	$10, %edi
	jne	.L2
	movl	%r9d, %edx
	leaq	.LC0(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movl	$0, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE23:
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
