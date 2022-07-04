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
freq_arr: resd 50
i: resd 1
j: resd 1
var: resd 1
f: resd 1
max_f: resd 1
key: resd 1

section .text
global _start:
_start:

call read_num
mov eax,dword[just_read]
mov dword[n],eax

mov ebx,arr
mov eax,0
call read_array

call insertion_sort

mov ebx,arr
mov eax,0
call print_array

mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 80h

call frequency

mov ebx,freq_arr
mov eax,0
call print_array

mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 80h

call maxm

mov eax,dword[max_f]
mov dword[just_print],eax
call print_num

mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 80h

call new_array

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

insertion_sort:

pusha
mov ebx,arr

mov dword[j],0

loop_sort:
inc dword[j]
mov edx,dword[n]
cmp edx,dword[j]
je end_insertion_sort

mov edx,dword[j]
sub edx,1
mov dword[i],edx

mov eax,dword[j]
mov ecx,dword[ebx+(4*eax)]
mov dword[key],ecx

loop2:
mov edx,dword[i]
cmp edx,0
jl cond

mov ecx,dword[ebx+(4*edx)]
cmp dword[key],ecx
jng cond
mov eax,dword[i]
inc eax
mov dword[ebx+(4*eax)],ecx
dec dword[i]
jmp loop2

cond:
mov eax,dword[i]
inc eax
mov edx,dword[key]
mov dword[ebx+(4*eax)],edx
jmp loop_sort

end_insertion_sort:

popa
ret

frequency:

pusha

mov dword[i],0
loop3:
mov eax,dword[i]
cmp eax,dword[n]
je end_frequency
mov ebx,arr
mov ecx,dword[ebx+(4*eax)]
mov dword[var],ecx
call freq_count
inc dword[i]
jmp loop3



end_frequency:

popa
ret

freq_count:

pusha
mov dword[f],0
mov edx,0
loop:
cmp edx,dword[n]
je end_freq_count
mov ecx,dword[ebx+(4*edx)]
cmp ecx,dword[var]
je freq
inc edx
jmp loop

freq:
inc dword[f]
inc edx
jmp loop

end_freq_count:
mov eax,dword[i]
mov edx,freq_arr
mov ecx,dword[f]
mov dword[edx+(4*eax)],ecx


popa
ret

maxm:

pusha

mov ebx,freq_arr
mov ecx,0
mov edx,dword[ebx+(4*ecx)]
mov dword[max_f],edx
loop4:
inc ecx
mov eax,dword[n]
cmp ecx,eax
je end_maxm
mov edx,dword[ebx+(4*ecx)]
cmp edx,dword[max_f]
ja max_get
jmp loop4
max_get:
mov dword[max_f],edx
jmp loop4


end_maxm:

popa
ret

new_array:

pusha
mov dword[i],0

loop5:

mov ebx,freq_arr
mov eax,dword[i]
cmp dword[n],eax
je decrement
cmp dword[max_f],0
je end_new_array
mov ecx,dword[ebx+(4*eax)]
cmp ecx,dword[max_f]
je printn
inc dword[i]
jmp loop5


printn:
mov edx,arr
mov ecx,dword[edx+(4*eax)]
mov dword[just_print],ecx
call print_num
inc dword[i]
jmp loop5

decrement:
dec dword[max_f]
mov dword[i],0
jmp loop5


end_new_array:

popa
ret

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
