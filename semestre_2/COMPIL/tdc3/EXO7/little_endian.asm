; little_endian.asm
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
    mov eax, [rsi+2]
    ; rax en binaire : 00 00000110 00000000 00000010 = 
	call print_registers
    mov rax, 60
    mov rdi, 0
    syscall
