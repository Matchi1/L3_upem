section .data
ptr1 dq ""
section .text
global _start
extern print_registers
extern print_stack

lire:
	mov rax, 0
	mov rsi, rdi
	mov rdi, 0
	mov rdx, 1
	syscall
	ret

ecrire:
	mov rax, 1
	mov rsi, rdi
	mov rdi, 1
	mov rdx, 2
	syscall
	ret

_start:
	mov rdi, ptr1
	call lire
	add byte[ptr1], 1
	mov byte[ptr1 + 1], 10
	mov rdi, ptr1
	call ecrire
	mov rax, 60
	mov rdi, 0
	syscall
