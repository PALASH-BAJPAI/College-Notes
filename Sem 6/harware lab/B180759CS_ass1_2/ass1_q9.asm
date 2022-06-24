section .data
zero: db '0'
l1: equ $-zero
space: db ' '
l2: equ $-space

section .bss
just_read: resd 1
just_print: resd 1
temp: resd 1
counter: resd 1
a: resd 1
i: resd 1
sum: resd 1

section .text
global _start:
_start:
call read_num
mov eax,dword[just_read]
mov dword[a],eax

mov eax,1
mov dword[i],eax
mov dword[sum],0
for:
	mov eax,dword[i]
	cmp eax,dword[a]
	ja end
	add dword[sum],eax
	inc dword[i]
	jmp for

end:
	mov eax,dword[sum]
	mov dword[just_print],eax
	call print_num

	mov eax,1
	mov ebx,0
	int 80h

read_num:
	pusha
	mov dword[just_read],0
	
	reading:
		mov eax,3
		mov ebx,0
		mov ecx,temp
		mov edx,1
		int 80h

		cmp dword[temp],10
		je end_read

		sub dword[temp],30h
		mov eax,dword[just_read]
		mov edx,0
		mov ebx,10
		mul ebx

		add eax,dword[temp]
		mov dword[just_read],eax
		jmp reading

	end_read:
		popa
		ret
print_num:
	pusha
	mov dword[counter],0
	cmp dword[just_print],0

	jne extracting

	mov eax,4
	mov ebx,1
	mov ecx,zero
	mov edx,l1
	int 80h

	jmp end_print

	extracting:
		cmp dword[just_print],0
		je printing
		mov eax,dword[just_print]
		mov edx,0
		mov ebx,10
		div ebx
		push edx
		mov dword[just_print],eax
		inc dword[counter]
		jmp extracting

	printing:
		cmp dword[counter],0
		je end_print

		pop edx
		mov dword[temp],edx
		add dword[temp],30h
		mov eax,4
		mov ebx,1
		mov ecx,temp
		mov edx,1
		int 80h
		dec dword[counter]
		jmp printing
end_print:
	popa
	ret
