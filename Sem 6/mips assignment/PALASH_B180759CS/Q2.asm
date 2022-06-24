section .data
format1: db "%lf",0
format2: db " Multiplication is : %lf",10
format3: db "%d", 0
msg1: db "Enter The first number : "
len1: equ $-msg1
msg2: db "Enter The second number :"
len2: equ $-msg2

section .bss
float1: resq 1
float2: resq 1

section .text
global main
extern scanf
extern printf

main:
mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,len1
int 80h
call read_float
fstp qword[float1]

mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,len2
int 80h

call read_float
fst qword[float2]
fld qword[float1]
fmul ST1

call print_float
ffree ST1
ffree ST2

EXIT:
mov eax, 1
mov ebx, 0
int 80h

read_float:
push ebp
mov ebp, esp
sub esp, 8
lea eax, [esp]
push eax
push format1
call scanf
fld qword[ebp - 8]
mov esp, ebp
pop ebp
ret

print_float:
push ebp
mov ebp, esp
sub esp, 8
fst qword[ebp - 8]
push format2
call printf
mov esp, ebp
pop ebp
ret

