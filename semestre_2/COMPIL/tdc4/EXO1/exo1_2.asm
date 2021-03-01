section .text
global _start
extern print_registers
extern print_stack
_start:
	mov rbx, 0		
	mov r12, 0
	mov r13, 0
	mov r14, 2		; index
	push 0
	push 1
	jmp fibo

fibo: 
	cmp r14, 30
	jg end
	mov rbx, 0
	pop r13			; dernière valeur calculer
	pop r12			; avant-dernière valeur calculer
	add rbx, r13
	add rbx, r12
	push r12
	push r13
	push rbx
	inc r14
	jmp fibo

end:
	mov r12, 0
	mov r13, 0
	mov r14, 0
	pop rbx
	call print_registers
	mov rax, 60
	mov rdi, 0
	syscall
