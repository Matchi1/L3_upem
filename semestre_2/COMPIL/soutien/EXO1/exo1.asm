section .data
table dw 1, 2, 6, 3, 4, 22, 10, 0
section .text
global _start
extern print_registers
extern print_stack
_start:
	call print_stack
	push rbp
	mov rbp, rsp
	sub rsp, 40
	call print_stack
	mov qword[rbp - 24], 3
	mov rbx, qword[rbp - 24]
	add rsp, 40
	pop rbp
	call print_stack
	mov rax, 60
	mov rdi, 0
	syscall
