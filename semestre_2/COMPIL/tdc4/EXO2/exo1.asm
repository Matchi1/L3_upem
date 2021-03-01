section .data
table dw 1, 2, 6, 3, 4, 22, 10, 0
section .text
global _start
extern print_registers
extern print_stack
_start:
	mov rbx, 0		
	mov r12, 0					; résultat de la division par 2
	mov r13, 0					; résultat de la multiplication par 2
	mov r14, 0 					; index table
	call print_stack
	push rbp				; Début bloc d'activation
	mov rbp, rsp
	sub rsp, 8				; taille de la pile (4 octets)
	mov qword[rbp - 8], 0	; compteur de nombre pair
	jmp browse

browse:
	mov rsi, table
	mov r13w, word[rsi + r14]	; on attribue une valeur dans la table
	call print_registers
	cmp r13, 0					; fin du programme
	je end
	mov eax, r13d
	mov ecx, 2
	div ecx
	cmp edx, 0
	je paire
	add r14, 2
	jmp browse

paire:
	inc qword[rbp - 8]
	add r14, 2
	jmp browse

end:
	mov rbx, [rbp - 8]			; nombre de valeur pair
	call print_registers
	call print_stack
	mov rsp, rbp	
	pop rbp
	call print_stack
	mov rax, 60
	mov rdi, 0
	syscall
