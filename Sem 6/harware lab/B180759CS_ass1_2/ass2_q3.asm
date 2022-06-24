section .data
m:db "  "
l: equ $-m
m1:db "Enter The size of array",10
l1: equ $-m1
m2:db "Enter the elements of array",10
l2: equ $-m2

section .bss
just_read: resd 1
temp: resd 1
just_print: resd 1
counter: resd 1
arr: resd 100
i: resd 1
n: resd 1
max: resd 1
min: resd 1
pepsi: resd 1

section .text
global _start:
_start:
mov eax,4
mov ebx,1
mov ecx,m1
mov edx,l1
int 80h
call read_num
mov eax,dword[just_read]
mov dword[n],eax

mov eax,4
mov ebx,1
mov ecx,m2
mov edx,l2
int 80h

call read_array
;call print_array
mov ebx,arr
mov eax,0
mov dword[i],0
mov eax,dword[ebx]
mov dword[max],eax

max1:
mov eax,dword[i]
cmp eax,dword[n]
je end_max
mov ecx,dword[ebx+eax*4]
cmp ecx,dword[max]
ja maximum
inc dword[i]
jmp max1


maximum:
mov dword[max],ecx
inc dword[i]
jmp max1

end_max:
mov eax,dword[max]
mov dword[just_print],eax
call print_num
mov eax,4
mov ebx,1
mov ecx,m
mov edx,l
int 80h

mov ebx,arr                                                                                                                                                                 
mov eax,dword[ebx]
mov dword[min],eax
mov dword[i],0

min1:
mov eax,dword[i]
cmp eax,dword[n]
je end_min 
mov ecx,dword[ebx+eax*4]                                                                                                                                                    
cmp ecx,dword[min]
jb minimum
inc dword[i]
jmp min1

minimum:
mov dword[min],ecx
inc dword[i]
jmp min1

end_min:
mov eax,dword[min]
mov dword[just_print],eax                                                                                                                                                
call print_num
mov eax,4
mov ebx,1
mov ecx,m
mov edx,l
int 80h

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
	dec dword[counter]
	jmp printing

end_print:
	popa
	ret
	
		

