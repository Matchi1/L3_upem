section .text
global _start
extern print_registers
_start:
	; votre code viendra ici
	mov rax, 60
	mov rdi, 0
	syscall
