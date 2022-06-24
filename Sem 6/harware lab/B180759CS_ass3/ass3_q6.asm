section .data
tab: db 9
newline: db 10

section .bss
just_read: resd 1
just_print: resd 1
temp: resd 1
counter: resd 1
zero: resd 1
n: resd 1
arr: resd 50
a: resd 1
b: resd 1
i: resd 1
var: resd 1


section .text
global _start:
_start:

call read_num
mov eax,dword[just_read]
mov dword[n],eax

mov ebx,arr
mov eax,0
call read_array

call read_num
mov eax,dword[just_read]
mov dword[a],eax

call read_num 
mov eax,dword[just_read]
mov dword[b],eax

mov dword[i],0

loop:
mov ebx,arr
mov ecx,dword[i]
cmp ecx,dword[n]
je print_newline

mov eax,dword[ebx+(4*ecx)]
mov dword[var],eax

mov eax,dword[var]
mov ebx,dword[a]
mov edx,0
div ebx
cmp edx,0
je check_another
inc dword[i]
jmp loop

check_another:
mov eax,dword[var]
mov ebx,dword[b]
mov edx,0
div ebx
cmp edx,0
je print1
inc dword[i]
jmp loop

print1:
mov eax,dword[var]
mov dword[just_print],eax
call print_num
inc dword[i]
jmp loop


print_newline:
mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 80h

end:
mov eax,1
mov ebx,0
int 80h

read_array:

pusha
read_loop:
cmp eax,dword[n]
je end_read_array
call read_num
mov ecx,dword[just_read]
mov dword[ebx+(4*eax)],ecx
inc eax
jmp read_loop

end_read_array:

popa
ret

print_array:

mov ebx,arr
mov eax,0

pusha
print_loop:
cmp eax,dword[n]
je end_print_array
mov ecx,dword[ebx+(4*eax)]
mov dword[just_print],ecx
call print_num
inc eax
jmp print_loop

end_print_array:

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
mov ebx,1
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
mov eax,4
mov ebx,1
mov ecx,tab
mov edx,1
int 80h

popa
ret
