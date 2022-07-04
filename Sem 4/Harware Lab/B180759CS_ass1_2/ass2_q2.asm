section .data
m:db "0 "
l: equ $-m
m1: db "1 "
l1: equ $-m1
m2: db " "
l2: equ $-m2
m3: db 'Enter the element to be searched for',10
l3: equ $-m3
m4: db 'Enter the size of array',10
l4: equ $-m4
m5: db "Enter the elements of array",10
l5: equ $-m5

section .bss
just_read: resd 1
temp: resd 1
just_print: resd 1
counter: resd 1
arr: resd 100
i: resd 1
n: resd 1
k: resd 1


section .text
global _start:
_start:
mov eax,4
mov ebx,1
mov ecx,m3
mov edx,l3
int 80h

call read_num
mov eax,dword[just_read]
mov dword[k],eax

mov eax,4
mov ebx,1
mov ecx,m4
mov edx,l4
int 80h

call read_num
mov eax,dword[just_read]
mov dword[n],eax

mov eax,4
mov ebx,1
mov ecx,m5
mov edx,l5
int 80h

call read_array
;call print_array
mov ebx,arr
mov eax,0
mov dword[i],0

find:
mov eax,dword[i]
cmp eax,dword[n]
je end_find
mov ecx,dword[ebx+eax*4]
cmp ecx,dword[k]
je found
inc dword[i]
jmp find

end_find:
mov eax,4
mov ebx,1
mov ecx,m
mov edx,l
int 80h
jmp end

found:
mov dword[just_print],ecx
;call print_num
mov eax,4
mov ebx,1
mov ecx,m1
mov edx,l1
int 80h
jmp end

end:
mov eax,1
mov ebx,0
int 80h



read_array:
pusha
mov ebx,arr
mov dword[i],0
	read:
		mov eax,dword[i]
		cmp eax,dword[n]
		je end_readarray
		call read_num
		mov ecx,dword[just_read]
		mov dword[ebx+eax*4],ecx
		inc dword[i]
		jmp read

print_array:
pusha
mov ebx,arr
mov dword[i],0
        print:
                mov eax,dword[i]
                cmp eax,dword[n]
                je end_printarray
                mov ecx,dword[ebx+eax*4]
		mov dword[just_print],ecx
		call print_num
                inc dword[i]
                jmp print
end_printarray:
popa
ret

end_readarray:
popa
ret
	

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
		mov eax,dword[just_read]
		sub dword[temp],30h
		mov ebx,10
		mov edx,0
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
	extracting:
		cmp dword[just_print],0
		je printing
		mov eax,dword[just_print]
		mov ebx,10
		mov edx,0
		div ebx
		push edx
		mov dword[just_print],eax
		inc dword[counter]
		jmp extracting
printing:
	cmp dword[counter],0
	je end_print
	pop edx
	add edx,30h
	mov dword[temp],edx
	mov  eax,4
	mov ebx,1
	mov ecx,temp
	mov edx,1
	int 80h
        mov eax,4
        mov ebx,1
        mov ecx,m2
        mov edx,l2
       int 80h
	dec dword[counter]
	jmp printing

end_print:
	popa
	ret
	
		

