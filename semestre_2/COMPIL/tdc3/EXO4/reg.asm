; reg.asm
; registres, chevauchements, appel de fonction
section .text
global _start
extern print_stack
extern print_registers

_start:
  mov rax, 0
  jmp loop

loop:
  cmp rax, 100
  jge greater
  	add rax, 9
	jmp loop

greater:
  call print_registers
  mov rax, 60
  mov rdi, 1
  syscall
