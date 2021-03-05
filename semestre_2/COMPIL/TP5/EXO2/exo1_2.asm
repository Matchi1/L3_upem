section .text
global _start
extern print_registers
extern square

_start:
	mov rdi, 9
	push rsp
	and rsp, -16
	call square
	mov rbx, rax
	call print_registers 	; le carré est situé dans rdi
	pop rsp
	mov rax, 60
	mov rdi, 0
	syscall
