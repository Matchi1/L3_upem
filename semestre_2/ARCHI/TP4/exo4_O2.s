	.file	"exo4.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.globl	fac
	.type	fac, @function
fac:
	endbr64
	mov	eax, 1
	cmp	edi, 1
	jle	.L4
	.p2align 4,,10
	.p2align 3
.L3:
	mov	edx, edi
	sub	edi, 1
	imul	eax, edx
	cmp	edi, 1
	jne	.L3
	ret
	.p2align 4,,10
	.p2align 3
.L4:
	ret
	.size	fac, .-fac
	.p2align 4
	.globl	fac2_rec
	.type	fac2_rec, @function
fac2_rec:
	endbr64
	mov	eax, esi
	cmp	edi, 1
	jle	.L8
	.p2align 4,,10
	.p2align 3
.L9:
	imul	eax, edi
	sub	edi, 1
	cmp	edi, 1
	jne	.L9
.L8:
	ret
	.size	fac2_rec, .-fac2_rec
	.p2align 4
	.globl	fac2
	.type	fac2, @function
fac2:
	endbr64
	mov	eax, 1
	cmp	edi, 1
	jle	.L14
	.p2align 4,,10
	.p2align 3
.L13:
	imul	eax, edi
	sub	edi, 1
	cmp	edi, 1
	jne	.L13
	ret
	.p2align 4,,10
	.p2align 3
.L14:
	ret
	.size	fac2, .-fac2
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
