section .data
m: db 'Enter the length',10
l: equ $-m
m1: db 'Enter the breadth',10
l1: equ $-m1
newline: db '',10
l2: equ $-newline

section .bss
temp: resd 1
counter: resd 1
just_read: resd 1
just_print: resd 1
zero: resd 1
a: resd 1
b: resd 1
area: resd 1
p: resd 1
junk: resd 1

section .text
global _start:
_start:

call read



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
mov dword[zero],30h
mov eax,4
mov eax,1
mov ecx,zero
mov edx,1
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
add edx,30h
mov dword[temp],edx
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























