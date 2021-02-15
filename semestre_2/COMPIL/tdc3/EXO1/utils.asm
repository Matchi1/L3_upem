; utils.asm
extern printf

section .data
    format_registers db "rax:0x%lx rbx:0x%lx rcx:%ld rdx:%ld", 10, 0
    format_stack db "sommet (rsp): 0x%lx, base du bloc (rbp): 0x%lx", 10, 0

section .text

global print_stack
global print_registers

print_registers:
    push rbp
    mov rbp, rsp
    
    push rax
    push rcx
    push rdx
    push rdi
    push rsi
    push r8
    
    mov r8, rdx 
    mov rcx, rcx
    mov rdx, rbx
    mov rsi, rax
    mov rdi, format_registers
    mov rax, 0
    call printf 
    
    pop r8
    pop rsi
    pop rdi
    pop rdx
    pop rcx
    pop rax
    
    pop rbp
    ret

print_stack:
    push rbp
    mov rbp, rsp

    push rax
    push rdx
    push rdi
    push rsi

    mov rdx, [rsp+32]
    
    mov rax, rsp
    add rax, 48
    mov rsi, rax
     
    mov rdi, format_stack
    mov rax, 0
    call printf WRT ..plt
    
    pop rsi
    pop rdi
    pop rdx
    pop rax
    
    pop rbp
    ret
