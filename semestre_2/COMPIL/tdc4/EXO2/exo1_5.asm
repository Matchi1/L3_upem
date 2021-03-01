section .text
global _start
extern print_registers
extern print_stack
_start:
	mov rax, 30	; première valeur
	mov rbx, 20	; deuxième valeur
	mov rcx, 0		; divisor
	mov rdx, 0
	cmp rax, rbx
	jng not_greater
	jmp pgcd

not_greater:
	mov rcx, rax
	mov rax, rbx
	mov rbx, rcx
	jmp pgcd	

pgcd:
	mov rcx, rbx		; divisor
	mov rdx, 0			; clear dividend
	div ecx				; division
	cmp rdx, 0
	je end
	jmp swap

swap:
	mov rax, rbx		; dividend
	mov rcx, rdx		; divisor
	mov rbx, rdx
	jmp pgcd

end:
	call print_registers	; pgcd = rbx
	mov rax, 60
	mov rdi, 0
	syscall
