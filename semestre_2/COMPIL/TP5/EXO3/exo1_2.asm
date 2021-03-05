section .text
global _start
extern print_registers
extern square

_start:
	mov r12, 9
	call square
	call print_registers 	; le carré est situé dans r12
	mov rax, 60
	mov rdi, 0
	syscall
