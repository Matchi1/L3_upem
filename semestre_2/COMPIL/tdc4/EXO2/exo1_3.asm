section .text
global _start
extern print_registers
extern print_stack
_start:
	mov rax, 10		; valeur
	mov rbx, 0		; factorielle		
	mov rcx, rax	; compteur
	sub rcx, 1
	jmp fact

fact:
	cmp rcx, 1
	je end
	mul rcx
	sub rcx, 1
	jmp fact

end:
	mov r12, rax	; valeur de la factorielle
	call print_registers
	mov rax, 60
	mov rdi, 0
	syscall
