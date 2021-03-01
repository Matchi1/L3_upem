section .text
global _start
extern print_registers
extern print_stack
_start:
	mov rbx, 0		
	mov r13, 1
	mov r14, 2					; compteur
	mov rdx, 0
	mov eax, edi
	mov ecx, r14d
	div ecx
	cmp edx, 0
	je non_premier
	add r14, 1
	jmp browse

browse:
	mov rbx, rdi
	cmp r14, rbx				; la valeur est un nombre premier ?
	jg premier
	mov eax, ebx
	mov ecx, r14d
	div ecx
	cmp edx, 0
	je non_premier
	add r14, 2
	call print_registers
	jmp browse

premier:
	mov rbx, 1
	jmp end

non_premier:
	mov rbx, 0
	jmp end

end:
	call print_registers
	mov rax, 60
	mov rdi, 0
	syscall
