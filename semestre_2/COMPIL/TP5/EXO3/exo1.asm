section .text
global _start
extern print_registers

square:
	push rbp
	mov rbp, rsp
	sub rsp, 4
	mov dword[rbp - 4], r12d
	mov eax, dword[rbp - 4]
	mul eax
	mov r12, rax
	add rsp, 4
	pop rbp
	mov eax, 0
	ret

_start:
	mov r12, 9
	call square
	call print_registers 	; le carré est situé dans r12
	mov rax, 60
	mov rdi, 0
	syscall
