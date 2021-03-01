section .data
table dw 1, 2, 6, 3, 4, 22, 10, 0
section .text
global _start
extern print_registers
extern print_stack
_start:
	mov rbx, 0		
	mov r12, 0					; première valeur de comparaison
	mov r13, 0					; seconde valeur de comparaison
	mov r14, 0 					; index table
	call print_stack
	push rbp				; Début bloc d'activation
	mov rbp, rsp
	sub rsp, 32				; taille de la pile (4 octets)
	mov qword[rbp - 8], 0	; valeur max
	mov qword[rbp - 16], 40	; valeur min
	mov qword[rbp - 24], 0	; nombre de valeur positive
	mov qword[rbp - 32], 0 	; somme des valeurs dans la table
	jmp browse

browse:
	mov rsi, table
	mov rbx, qword[rbp - 16] 	; on attribue le min courant dans la pile
	mov r12, qword[rbp - 8] 	; on attribue le max courant dans la pile
	mov r13w, word[rsi + r14]	; on attribue une valeur dans la table
	call print_registers
	cmp r13, 0					; fin du programme
	je end
	inc qword[rbp - 24] 		; incremente le nombre de valeur non nul
	add qword[rbp - 32], r13	; ajoute la valeur de la table dans la somme
	cmp r12, r13
	jng not_greater				; on vérifie la valeur max
	cmp rbx, r13
	jg greater					; on vérifie la valeur min non nul
	add r14, 2
	jmp browse

not_greater:
	mov r12, r13
	mov qword[rbp - 8], r12
	cmp rbx, r13
	jg greater
	add r14, 2
	jmp browse
	
greater:
	mov rbx, r13	
	mov qword[rbp - 16], r13
	add r14, 2
	jmp browse

end:
	mov rbx, [rbp - 8]			; valeur max
	mov r12, [rbp - 16]			; valeur min
	mov r13, [rbp - 24]			; nombre de valeur positive
	mov r14, [rbp - 32]			; somme des valeurs de la table
	call print_registers
	call print_stack
	mov rsp, rbp	
	pop rbp
	call print_stack
	mov rax, 60
	mov rdi, 0
	syscall
