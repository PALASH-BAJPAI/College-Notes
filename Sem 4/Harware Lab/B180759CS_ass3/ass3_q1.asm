section .data
tab: db '',9
l: equ $-tab
newline: db '',10
l1: equ $-newline
msg2: db 'Present',10
l2: equ $-msg2
msg3: db 'Not Present',10
l3: equ $-msg3


section .bss
just_read: resd 1
just_print: resd 1
temp: resd 1
counter: resd 1
zero: resd 1
n: resd 1
arr: resd 50
check: resd 1
k: resd 1
i: resd 1
j: resd 1

section .text
global _start:
_start:

call read_num
mov eax,dword[just_read]
mov dword[n],eax

call read_num
mov eax,dword[just_read]
mov dword[k],eax

mov ebx,arr
mov eax,0
call read_array

mov ebx,arr
mov ecx,dword[k]
mov eax,dword[n]
dec eax
cmp ecx,dword[ebx+(4*eax)]
jng go1
mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,l3
int 80h
jmp end

go1:
mov eax,0
cmp ecx,dword[ebx+(4*eax)]
jnl front
mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,l3
int 80h
jmp end


front:
mov dword[i],0
mov edx,dword[n]
dec edx
mov dword[j],edx
jmp binary_search


end:
mov eax,1
mov ebx,0
int 80h

binary_search:

mov eax,dword[i]

cmp eax,dword[j]
jg print0

add eax,dword[j]
mov ebx,2
mov edx,0
div ebx
mov ebx,arr
mov ecx,dword[k]

cmp ecx,dword[ebx+(4*eax)]
je print1

cmp ecx,dword[ebx+(4*eax)]
jg cond1

dec eax
mov dword[j],eax
jmp binary_search


cond1:
inc eax
mov dword[i],eax
jmp binary_search

print0:
mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,l3
int 80h
jmp end

print1:
mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,l2
int 80h
jmp end


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
mov eax,4
mov ebx,1
mov ecx,tab
mov edx,l
int 80h
dec dword[counter]
jmp printing

end_print:

popa
ret
