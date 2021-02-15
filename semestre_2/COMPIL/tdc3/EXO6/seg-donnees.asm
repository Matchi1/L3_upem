; seg-donnees.asm
section .data
table dw 1, 2, 6, 3, 4, 22, 10, 0
section .text
global _start
extern print_registers
_start:
    mov rsi, table
	mov rax, 0
	mov rbx, 0
	mov rcx, 14
	mov rdx, 0
	jmp max

browse:
	mov rax, 0
	mov ax, [rsi+rbx]
	call print_registers
	cmp rax, 0
	je end
		add rbx, 2
		jmp browse

reverse_browse:
	mov rax, 0
	mov ax, [rsi+rbx]
	call print_registers
	cmp rbx, 0
	je end
		sub rbx, 2
		jmp reverse_browse

max:
	call print_registers
	mov rax, 0
	mov ax, [rsi+rcx]
	cmp rax, rbx
	jg max_aux
	jmp max_continue

max_aux:
	mov rbx, rax	
	jmp max_continue

max_continue:
	cmp rcx, 0
	je end
		sub rcx, 2
		jmp max
	
end:
	mov rax, 60
	mov rdi, 1
	syscall
