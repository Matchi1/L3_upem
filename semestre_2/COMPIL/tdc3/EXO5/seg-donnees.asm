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
    mov rcx, 0
    mov rdx, 0
    mov ax, [rsi]
    ; rax : 1, rbx : 0, rcx : 0, rdx : 0 
	call print_registers
    mov ax, [rsi+2]
    ; rax : 6, rbx : 0, rcx : 0, rdx : 0 
	call print_registers
    mov eax,0
    mov rdx, 5
    mov al, [rsi+rdx*2]
    mov eax,0
    ; rax : 4, rbx : 0, rcx : 0, rdx : 0 
	call print_registers
    mov rax, 60
    mov rdi, 0
    syscall
