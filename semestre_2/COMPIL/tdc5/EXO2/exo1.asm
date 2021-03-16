section .text
global _start
extern print_registers

square:
	push rbp
	mov rbp, rsp
	sub rsp, 4
	mov dword[rbp - 4], edi
	mov eax, dword[rbp - 4]
	mul eax
	add rsp, 4
	pop rbp
	ret

_start:
	mov rdi, 9
	push rsp
	and rsp, -16
	call square
	mov rbx, rax
	call print_registers 	; le carré est situé dans r12
	pop rsp
	mov rax, 60
	mov rdi, 0
	syscall
