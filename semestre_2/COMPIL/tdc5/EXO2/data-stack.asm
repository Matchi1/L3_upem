; pour montrer le fonctionnement du stack
; nasm data-stack.asm -o data-stack.o  -f elf64 && gcc -o data-stack data-stack.o -nostartfiles -no-pie
section .data
    format_registers db "Registers  :   rbx:0x%lx r12:0x%lx r13:%ld r14:%ld", 10, 0
    format_stack db "Stack  :   sommet (rsp): 0x%lx, valeur du top : 0x%lx", 10, 0
    
    table dw 1, 2, 3, 4, 5, 6, 7, 0
    
section .text
global _start
extern printf

_start:
    push rbp
    mov rbp,rsp
    
    push qword 0xbeef
    ; push qword 0xff00
    sub rsp, 8
    mov qword [rsp], 0xffff

fin:
    mov rbx, [rbp-8]
    mov r12, [table]
    mov r13, 0
    mov r14, 0
    call print_registers
    call print_stack
    
    pop rbx
    call print_registers
    
    push 3
    call print_stack
    
    push 5
    call print_stack

    
    mov rsp, rbp
    pop rbp
	mov rax, 60 ; code for the syscall
	mov rdi, 0 ; return value 
	syscall


print_registers:
    push rbp
    mov rbp, rsp
    
    mov r8,  r14
    mov rcx, r13
    mov rdx, r12
    mov rsi, rbx
    mov rdi, format_registers
    mov rax, 0
    call printf 
        
    pop rbp
    ret

print_stack:
    push rbp
    mov rbp, rsp

    mov rdx, [rsp]
    mov rax, rsp
    add rax, 16
    mov rdx, [rax]
    mov rsi, rax
    mov rdi, format_stack
    mov rax, 0
    call printf WRT ..plt
    
    pop rbp
    ret
