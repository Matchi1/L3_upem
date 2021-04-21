	.file	"exo4.c"
	.intel_syntax noprefix
	.text
	.globl	fac
	.type	fac, @function
fac:
	endbr64
	mov	eax, 1
	cmp	edi, 1
	jg	.L8
	ret
.L8:
	push	rbx
	mov	ebx, edi
	lea	edi, -1[rdi]
	call	fac
	imul	eax, ebx
	pop	rbx
	ret
	.size	fac, .-fac
	.globl	fac2_rec
	.type	fac2_rec, @function
fac2_rec:
	endbr64
	mov	eax, esi
	cmp	edi, 1
	jg	.L15
	ret
.L15:
	sub	rsp, 8
	imul	eax, edi
	mov	esi, eax
	sub	edi, 1
	call	fac2_rec
	add	rsp, 8
	ret
	.size	fac2_rec, .-fac2_rec
	.globl	fac2
	.type	fac2, @function
fac2:
	endbr64
	sub	rsp, 8
	mov	esi, 1
	call	fac2_rec
	add	rsp, 8
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
