; reg.asm
; registres, chevauchements, appel de fonction
section .text
global _start
extern print_stack
extern print_registers

_start:
  mov rax, 2
  mov rbx, 3
  cmp rax, rbx
  jg greater
  je equals
  mov rax, 60
  mov rdi, -1
  syscall

greater:
  mov rax, 60
  mov rdi, 1
  syscall

equals:
  mov rax, 60
  mov rdi, 0
  syscall
