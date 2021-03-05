section .text
global square
extern print_registers

square:
	push rbp
	mov rbp, rsp
	sub rsp, 4
	mov dword[rbp - 4], edi
	mov eax, dword[rbp - 4]
	mul eax
	add rsp, 4
	pop rbp
	ret
