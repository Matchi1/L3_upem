	.file	"exo2.c"
	.text
	.p2align 4
	.globl	boucle1
	.type	boucle1, @function
boucle1:
.LFB39:
	.cfi_startproc
	endbr64
	movq	A(%rip), %rdi
	movl	$4000, %edx
	leaq	4(%rdi), %rsi
	jmp	memmove@PLT
	.cfi_endproc
.LFE39:
	.size	boucle1, .-boucle1
	.p2align 4
	.globl	boucle2
	.type	boucle2, @function
boucle2:
.LFB40:
	.cfi_startproc
	endbr64
	movq	B(%rip), %rdx
	movq	A(%rip), %rcx
	leaq	15(%rdx), %rax
	subq	%rcx, %rax
	cmpq	$30, %rax
	movl	$0, %eax
	jbe	.L4
	.p2align 4,,10
	.p2align 3
.L5:
	movdqu	(%rdx,%rax), %xmm0
	movups	%xmm0, (%rcx,%rax)
	addq	$16, %rax
	cmpq	$4000, %rax
	jne	.L5
	ret
	.p2align 4,,10
	.p2align 3
.L4:
	movl	(%rdx,%rax), %esi
	movl	%esi, (%rcx,%rax)
	addq	$4, %rax
	cmpq	$4000, %rax
	jne	.L4
	ret
	.cfi_endproc
.LFE40:
	.size	boucle2, .-boucle2
	.p2align 4
	.globl	boucle3
	.type	boucle3, @function
boucle3:
.LFB41:
	.cfi_startproc
	endbr64
	movq	B(%rip), %rdx
	movq	A(%rip), %rcx
	leaq	4(%rdx), %rsi
	leaq	16(%rcx), %rax
	cmpq	%rax, %rsi
	jnb	.L16
	leaq	20(%rdx), %rax
	cmpq	%rax, %rcx
	jb	.L15
.L16:
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L13:
	movdqu	4(%rdx,%rax), %xmm0
	movups	%xmm0, (%rcx,%rax)
	addq	$16, %rax
	cmpq	$3984, %rax
	jne	.L13
	movl	3988(%rdx), %eax
	movl	%eax, 3984(%rcx)
	movl	3992(%rdx), %eax
	movl	%eax, 3988(%rcx)
	movl	3996(%rdx), %eax
	movl	%eax, 3992(%rcx)
	ret
.L15:
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L11:
	movl	4(%rdx,%rax), %esi
	movl	%esi, (%rcx,%rax)
	addq	$4, %rax
	cmpq	$3996, %rax
	jne	.L11
	ret
	.cfi_endproc
.LFE41:
	.size	boucle3, .-boucle3
	.p2align 4
	.globl	boucle4
	.type	boucle4, @function
boucle4:
.LFB42:
	.cfi_startproc
	endbr64
	movq	B(%rip), %rcx
	movq	A(%rip), %rdx
	movl	$4, %eax
	.p2align 4,,10
	.p2align 3
.L20:
	movl	(%rcx,%rax), %esi
	movl	%esi, (%rdx,%rax)
	movl	4(%rcx,%rax), %esi
	movl	%esi, 4(%rdx,%rax)
	addq	$4, %rax
	cmpq	$3984, %rax
	jne	.L20
	ret
	.cfi_endproc
.LFE42:
	.size	boucle4, .-boucle4
	.p2align 4
	.globl	boucle5
	.type	boucle5, @function
boucle5:
.LFB43:
	.cfi_startproc
	endbr64
	movq	B(%rip), %rcx
	movq	A(%rip), %rdx
	movl	$4, %eax
	.p2align 4,,10
	.p2align 3
.L23:
	movl	(%rcx,%rax), %esi
	movl	%esi, (%rdx,%rax)
	movl	8(%rcx,%rax), %esi
	movl	%esi, 8(%rdx,%rax)
	addq	$8, %rax
	cmpq	$3988, %rax
	jne	.L23
	ret
	.cfi_endproc
.LFE43:
	.size	boucle5, .-boucle5
	.p2align 4
	.globl	boucle6
	.type	boucle6, @function
boucle6:
.LFB44:
	.cfi_startproc
	endbr64
	movq	B(%rip), %rdx
	movq	A(%rip), %rcx
	leaq	4(%rdx), %r8
	leaq	36(%rcx), %rsi
	cmpq	%r8, %rsi
	leaq	20(%rdx), %rax
	leaq	4(%rcx), %rdi
	setbe	%r9b
	cmpq	%rax, %rdi
	setnb	%r8b
	orb	%r8b, %r9b
	je	.L29
	leaq	36(%rdx), %r8
	cmpq	%r8, %rdi
	setnb	%dil
	cmpq	%rax, %rsi
	setbe	%al
	orb	%al, %dil
	je	.L29
	movl	$4, %eax
	.p2align 4,,10
	.p2align 3
.L27:
	movdqu	(%rdx,%rax), %xmm0
	movups	%xmm0, (%rcx,%rax)
	movdqu	16(%rdx,%rax), %xmm1
	movups	%xmm1, 16(%rcx,%rax)
	addq	$16, %rax
	cmpq	$3972, %rax
	jne	.L27
	movl	3972(%rdx), %eax
	movl	%eax, 3972(%rcx)
	movl	3988(%rdx), %eax
	movl	%eax, 3988(%rcx)
	movl	3976(%rdx), %eax
	movl	%eax, 3976(%rcx)
	movl	3992(%rdx), %eax
	movl	%eax, 3992(%rcx)
	movl	3980(%rdx), %eax
	movl	%eax, 3980(%rcx)
	movl	3996(%rdx), %eax
	movl	%eax, 3996(%rcx)
	ret
.L29:
	movl	$4, %eax
	.p2align 4,,10
	.p2align 3
.L26:
	movl	(%rdx,%rax), %esi
	movl	%esi, (%rcx,%rax)
	movl	16(%rdx,%rax), %esi
	movl	%esi, 16(%rcx,%rax)
	addq	$4, %rax
	cmpq	$3984, %rax
	jne	.L26
	ret
	.cfi_endproc
.LFE44:
	.size	boucle6, .-boucle6
	.p2align 4
	.globl	boucle7
	.type	boucle7, @function
boucle7:
.LFB45:
	.cfi_startproc
	endbr64
	movq	B(%rip), %rdx
	movq	A(%rip), %rcx
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	C(%rip), %rsi
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	leaq	20(%rdx), %rax
	leaq	4(%rcx), %r10
	leaq	4(%rdx), %r8
	cmpq	%r10, %rax
	leaq	20(%rcx), %rbx
	setbe	%dil
	leaq	4(%rsi), %r11
	leaq	20(%rsi), %r9
	cmpq	%r8, %rbx
	setbe	%bpl
	orl	%ebp, %edi
	cmpq	%r11, %rax
	setbe	%al
	cmpq	%r9, %r8
	setnb	%r8b
	orl	%r8d, %eax
	testb	%al, %dil
	je	.L42
	cmpq	%r11, %rbx
	setbe	%dil
	cmpq	%r9, %r10
	setnb	%al
	orb	%al, %dil
	je	.L42
	movl	$4, %eax
	.p2align 4,,10
	.p2align 3
.L40:
	movdqu	(%rdx,%rax), %xmm0
	movups	%xmm0, (%rcx,%rax)
	movdqu	(%rsi,%rax), %xmm1
	movups	%xmm1, (%rdx,%rax)
	addq	$16, %rax
	cmpq	$3972, %rax
	jne	.L40
	movl	3972(%rdx), %eax
	movl	%eax, 3972(%rcx)
	movl	3972(%rsi), %eax
	movl	%eax, 3972(%rdx)
	movl	3976(%rdx), %eax
	movl	%eax, 3976(%rcx)
	movl	3976(%rsi), %eax
	movl	%eax, 3976(%rdx)
	movl	3980(%rdx), %eax
	movl	%eax, 3980(%rcx)
	movl	3980(%rsi), %eax
	movl	%eax, 3980(%rdx)
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L42:
	.cfi_restore_state
	movl	$4, %eax
	.p2align 4,,10
	.p2align 3
.L39:
	movl	(%rdx,%rax), %edi
	movl	%edi, (%rcx,%rax)
	movl	(%rsi,%rax), %edi
	movl	%edi, (%rdx,%rax)
	addq	$4, %rax
	cmpq	$3984, %rax
	jne	.L39
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE45:
	.size	boucle7, .-boucle7
	.p2align 4
	.globl	boucle8
	.type	boucle8, @function
boucle8:
.LFB46:
	.cfi_startproc
	endbr64
	movq	B(%rip), %rdx
	movq	A(%rip), %rcx
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	C(%rip), %rsi
	leaq	24(%rdx), %rax
	leaq	4(%rcx), %r10
	leaq	4(%rdx), %r8
	cmpq	%rax, %r10
	leaq	20(%rcx), %rbx
	setnb	%dil
	leaq	4(%rsi), %r11
	leaq	20(%rsi), %r9
	cmpq	%r8, %rbx
	setbe	%al
	orl	%eax, %edi
	leaq	20(%rdx), %rax
	cmpq	%rax, %r11
	setnb	%al
	cmpq	%r9, %r8
	setnb	%r8b
	orl	%r8d, %eax
	testb	%al, %dil
	je	.L56
	cmpq	%r11, %rbx
	setbe	%dil
	cmpq	%r9, %r10
	setnb	%al
	orb	%al, %dil
	je	.L56
	movl	$4, %eax
	.p2align 4,,10
	.p2align 3
.L54:
	movdqu	4(%rdx,%rax), %xmm0
	movups	%xmm0, (%rcx,%rax)
	movdqu	(%rsi,%rax), %xmm1
	movups	%xmm1, (%rdx,%rax)
	addq	$16, %rax
	cmpq	$3972, %rax
	jne	.L54
	movl	3976(%rdx), %eax
	movl	%eax, 3972(%rcx)
	movl	3972(%rsi), %eax
	movl	%eax, 3972(%rdx)
	movl	3980(%rdx), %eax
	movl	%eax, 3976(%rcx)
	movl	3976(%rsi), %eax
	movl	%eax, 3976(%rdx)
	movl	3984(%rdx), %eax
	movl	%eax, 3980(%rcx)
	movl	3980(%rsi), %eax
	movl	%eax, 3980(%rdx)
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L56:
	.cfi_restore_state
	movl	$4, %eax
	.p2align 4,,10
	.p2align 3
.L53:
	movl	4(%rdx,%rax), %edi
	movl	%edi, (%rcx,%rax)
	movl	(%rsi,%rax), %edi
	movl	%edi, (%rdx,%rax)
	addq	$4, %rax
	cmpq	$3984, %rax
	jne	.L53
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE46:
	.size	boucle8, .-boucle8
	.p2align 4
	.globl	boucle9
	.type	boucle9, @function
boucle9:
.LFB47:
	.cfi_startproc
	endbr64
	movq	B(%rip), %rdx
	movq	A(%rip), %rdi
	movl	$4, %eax
	movq	C(%rip), %rsi
	.p2align 4,,10
	.p2align 3
.L67:
	movl	-4(%rdx,%rax), %ecx
	movl	%ecx, (%rdi,%rax)
	movl	(%rsi,%rax), %ecx
	movl	%ecx, (%rdx,%rax)
	addq	$4, %rax
	cmpq	$3984, %rax
	jne	.L67
	ret
	.cfi_endproc
.LFE47:
	.size	boucle9, .-boucle9
	.p2align 4
	.globl	boucle10
	.type	boucle10, @function
boucle10:
.LFB48:
	.cfi_startproc
	endbr64
	movq	B(%rip), %rdx
	movq	A(%rip), %rcx
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	C(%rip), %rsi
	leaq	48(%rdx), %rax
	leaq	16(%rcx), %r10
	leaq	16(%rdx), %r8
	cmpq	%rax, %r10
	leaq	32(%rcx), %rbx
	setnb	%dil
	leaq	16(%rsi), %r11
	leaq	32(%rsi), %r9
	cmpq	%r8, %rbx
	setbe	%al
	orl	%eax, %edi
	leaq	32(%rdx), %rax
	cmpq	%rax, %r11
	setnb	%al
	cmpq	%r9, %r8
	setnb	%r8b
	orl	%r8d, %eax
	testb	%al, %dil
	je	.L73
	cmpq	%r11, %rbx
	setbe	%dil
	cmpq	%r9, %r10
	setnb	%al
	orb	%al, %dil
	je	.L73
	movl	$16, %eax
	.p2align 4,,10
	.p2align 3
.L71:
	movdqu	16(%rdx,%rax), %xmm0
	movups	%xmm0, (%rcx,%rax)
	movdqu	(%rsi,%rax), %xmm1
	movups	%xmm1, (%rdx,%rax)
	addq	$16, %rax
	cmpq	$3984, %rax
	jne	.L71
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L73:
	.cfi_restore_state
	movl	$16, %eax
	.p2align 4,,10
	.p2align 3
.L70:
	movl	16(%rdx,%rax), %edi
	movl	%edi, (%rcx,%rax)
	movl	(%rsi,%rax), %edi
	movl	%edi, (%rdx,%rax)
	addq	$4, %rax
	cmpq	$3984, %rax
	jne	.L70
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE48:
	.size	boucle10, .-boucle10
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB49:
	.cfi_startproc
	endbr64
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$100, %esi
	movl	$4, %edi
	call	calloc@PLT
	movl	$100, %esi
	movl	$4, %edi
	movq	%rax, A(%rip)
	call	calloc@PLT
	movl	$100, %esi
	movl	$4, %edi
	movq	%rax, B(%rip)
	call	calloc@PLT
	movq	%rax, C(%rip)
	xorl	%eax, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE49:
	.size	main, .-main
	.comm	C,8,8
	.comm	B,8,8
	.comm	A,8,8
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
