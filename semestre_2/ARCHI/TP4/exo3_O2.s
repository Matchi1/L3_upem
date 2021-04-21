	.file	"exo2.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.globl	sum
	.type	sum, @function
sum:
	endbr64
	test	edi, edi
	jle	.L4
	xor	eax, eax
	xor	r8d, r8d
	.p2align 4,,10
	.p2align 3
.L3:
	add	r8d, eax
	add	eax, 1
	cmp	edi, eax
	jne	.L3
	mov	eax, r8d
	ret
	.p2align 4,,10
	.p2align 3
.L4:
	xor	r8d, r8d
	mov	eax, r8d
	ret
	.size	sum, .-sum
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
	endbr64
	mov	eax, 1
	ret
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
