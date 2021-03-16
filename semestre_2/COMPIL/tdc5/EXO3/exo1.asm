section .data
ptr1 dq 5
ptr2 dq 6
section .text
global _start
extern print_registers
extern print_stack

exchange:    
	push rbx        ; garder sa valeur, rbx n'est pas volatile !
	mov  rax, [rdi]  ; 8 bytes !
	mov  rbx, [rsi] ; 8 bytes
	mov [rsi], rax
	mov [rdi], rbx
	pop rbx         ; reprendre la valeur de rbx qu'on avait perdu
	ret

_start:
	mov rdi, ptr1
	mov rsi, ptr2

	mov rax, rsp				; début de l'alignement de la pile
	mov rbx, 16
	idiv rbx
	sub rsp, rdx				; alignement de la pile
	call print_stack

	mov r12, rdi
	mov r13, rsi
	call print_registers			; les valeurs témoins

	call exchange

	mov r12, rdi
	mov r13, rsi
	call print_registers

	mov rax, 60
	mov rdi, 0
	syscall
