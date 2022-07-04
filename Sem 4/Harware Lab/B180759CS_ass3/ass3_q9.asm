section .data
tab: db 9
newline: db 10
msg1: db 'Matrix1:',10
l1: equ $-msg1
msg2: db 'Matrix2:',10
l2: equ $-msg2
row1: db 'Matrix1 ROWS:',10
r1: equ $-row1
col1: db 'Matrix1 COLUMNS:',10
c1: equ $-col1
row2: db 'Matrix2 ROWS:',10
r2: equ $-row2
col2: db 'Matrix2 COLUMNS:',10
c2: equ $-col2
mulmatrix: db 'Multiplication of Two Matrices:',10
mm: equ $-mulmatrix


section .bss
just_read: resd 1
just_print: resd 1
temp: resd 1
counter: resd 1
zero: resd 1
i: resd 1
j: resd 1
m: resd 1
n: resd 1
m1: resd 1
n1: resd 1
arr1: resd 50
m2: resd 1
n2: resd 1
arr2: resd 50
i1: resd 1
j1: resd 1
i2: resd 1
j2: resd 1
t1: resd 1
t2: resd 1
c: resd 1
sum: resd 1


section .text
global _start:
_start:

mov eax,4
mov ebx,1
mov ecx,row1
mov edx,r1
int 80h
call read_num
mov eax,dword[just_read]
mov dword[m1],eax


mov eax,4
mov ebx,1
mov ecx,col1
mov edx,c1
int 80h
call read_num
mov eax,dword[just_read]
mov dword[n1],eax

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,l1
int 80h
mov eax,dword[m1]
mov dword[m],eax
mov eax,dword[n1]
mov dword[n],eax
mov ebx,arr1
mov eax,0
mov dword[i],0
call read_2Darray

mov eax,4
mov ebx,1
mov ecx,row2
mov edx,r2
int 80h
call read_num
mov eax,dword[just_read]
mov dword[m2],eax

mov eax,4
mov ebx,1
mov ecx,col2
mov edx,c2
int 80h
call read_num
mov eax,dword[just_read]
mov dword[n2],eax


mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,l2
int 80h
mov eax,dword[m2]
mov dword[m],eax
mov eax,dword[n2]
mov dword[n],eax
mov ebx,arr2
mov eax,0
mov dword[i],0
call read_2Darray

mov eax,4
mov ebx,1
mov ecx,mulmatrix
mov edx,mm
int 80h

mul_matrix:

mov dword[i1],0
mov dword[j2],0

row_loop_arr1:
mov dword[j1],0
mov dword[i2],0

col_loop_arr1:
mov eax,dword[i1]
mov ebx,dword[n1]
mul ebx
add eax,dword[j1]
mov ebx,arr1
mov ecx,dword[ebx+(4*eax)]
mov dword[t1],ecx

loop_arr2:
mov eax,dword[i2]
mov ebx,dword[n2]
mul ebx
add eax,dword[j2]
mov ebx,arr2
mov ecx,dword[ebx+(4*eax)]
mov dword[t2],ecx
mov eax,dword[t1]
mov ebx,dword[t2]
mul ebx
add dword[sum],eax
inc dword[j1]
inc dword[i2]
mov eax,dword[i2]
cmp eax,dword[m2]
jb col_loop_arr1
mov eax,dword[sum]
mov dword[just_print],eax
call print_num
mov dword[sum],0
inc dword[j2]
mov eax,dword[j2]
cmp eax,dword[n2]
jb row_loop_arr1
mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 80h
inc dword[i1]
mov dword[j2],0
mov eax,dword[i1]
cmp eax,dword[m1]
je print_newline
jmp row_loop_arr1

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

read_2Darray:

pusha

row_loop1:
mov dword[j],0

col_loop1:
call read_num
mov ecx,dword[just_read]
mov dword[ebx+(4*eax)],ecx
inc eax
inc dword[j]
mov ecx,dword[j]
cmp ecx,dword[n]
jb col_loop1
inc dword[i]
mov ecx,dword[i]
cmp ecx,dword[m]
jb row_loop1

end_read_2Darray:

popa
ret

print_2Darray:

pusha
mov dword[i],0

row_loop2:
mov dword[j],0

col_loop2:
mov ecx,dword[ebx+(4*eax)]
mov dword[just_print],ecx
call print_num

pusha
mov eax,4
mov ebx,1
mov ecx,tab
mov edx,1
int 80h
popa

inc eax
inc dword[j]
mov ecx,dword[j]
cmp ecx,dword[n]
jb col_loop2

pusha 
mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 80h
popa

inc dword[i]
mov ecx,dword[i]
cmp ecx,dword[m]
jb row_loop2

end_print_2Darray:

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
