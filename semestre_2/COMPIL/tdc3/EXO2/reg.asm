; reg.asm
; registres, chevauchements, appel de fonction
section .text
global _start
extern print_stack
extern print_registers

_start:
	mov rax, 2
	mov rbx, 10
	mov rcx, 0
	mov rdx, 0
	call print_registers
	add rax, rbx
	call print_registers
	add al, 2
	call print_registers
	mov eax, 256
	mov cl, ah
	call print_registers
	add ah, 1
	call print_registers
	mov rax, 60
	mov rdi, 0
	syscall
