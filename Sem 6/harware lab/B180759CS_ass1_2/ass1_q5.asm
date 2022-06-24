section .data
msg1: db 'Given number is a palindrome',10
l1: equ $-msg1
msg2: db 'Given number is not a palindrome',10
l2: equ $-msg2

section .bss
d1: resd 1
d2: resd 1
d3: resd 1
junk: resd 1

section .text
global _start:
_start:

mov eax,3
mov ebx,0
mov ecx,d1
mov edx,1
int 80h

mov eax,3
mov ebx,0
mov ecx,d2
mov edx,1
int 80h

mov eax,3
mov ebx,0
mov ecx,d3
mov edx,1
int 80h

mov eax,3
mov ebx,0
mov ecx,junk
mov edx,1
int 80h


mov eax,dword[d1]
cmp eax,dword[d3]
je equal

mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,l2
int 80h

end:
	mov eax,1
	mov ebx,0
	int 80h

equal:
	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,l1
	int 80h

	jmp end
