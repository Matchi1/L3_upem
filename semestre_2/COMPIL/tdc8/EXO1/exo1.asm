section .data
table dq 10, 6, 20, 1, 0
section .text
global _start
extern print_registers
extern print_stack

_start:
	mov rsi, table
	push rbp
	mov rbp, rsp
	push qword[rsi]
	push qword[rsi + 8]
	pop r11
	pop r12
	sub r12, r11	; e0 - e1
	push r12
	push qword[rsi + 16]
	push qword[rsi + 24]
	pop r11
	pop r12
	add r11, r12	; e3 + e4
	push r11
	pop rax
	pop rbx
	imul rbx		; (e0 - e1)(e3 + e4)
	push rax
	pop rbx
	call print_registers
	mov [rsi + 32], rbx
	pop rbp
	mov rax, 60
	mov rdi, 0
	syscall
