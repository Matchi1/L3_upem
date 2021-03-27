section .text
extern print_registers
extern print_stack

global mult2

mult2:
	push rbx
	push rbp
	mov rbp, rsp

	mov rax, rdi
	mov rbx, 2
	mul rbx
	mov rdi, rax

	pop rbp
	pop rbx
	ret

