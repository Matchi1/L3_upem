section .text
global _start
extern print_registers
extern print_stack

multiply:
	add r12, rsi
	sub rdi, 1
	cmp rdi, 0
	jg multiply
	ret

_start:
	call print_stack
	call print_registers
	push rsp
	push r12 				; sauvegarde des registres non-volatils

	mov rax, rsp			; début de l'alignement de la pile
	mov rbx, 16
	idiv rbx
	sub rsp, rdx			; alignement de la pilt

	mov rdi, 10				; premier paramètre
	mov rsi, 11				; second paramètre
	mov r12, 0				; resultat
	call multiply

	call print_stack
	call print_registers

	pop r12
	pop rsp					; rétablissement de l'adresse de base de la pile
	call print_registers
	call print_stack
	mov rax, 60
	mov rdi, 0
	syscall
