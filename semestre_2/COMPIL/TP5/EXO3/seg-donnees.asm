section .text
global square
extern print_registers

square:
	push rbp
	mov rbp, rsp
	sub rsp, 4
	mov dword[rbp - 4], r12d
	mov eax, dword[rbp - 4]
	mul eax
	mov r12, rax
	add rsp, 4
	pop rbp
	mov eax, 0
	ret
