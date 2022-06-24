section .data
msg1: db 'Enter a : '
len1: equ $-msg1
msg2: db 'Enter b : '
len2: equ $-msg2
msg3: db 'Enter c : '
len3: equ $-msg3 
msg4: db 'Roots are Imaginary.'
len4: equ $-msg4 
x: dq 4 
y: dq 2
newline: dw 10
format1: db "%lf",0
format2: db "the root is : %lf",10

section .bss
float1: resq 1
float2: resq 1
float3: resq 1
d: resq 1
d1: resq 1

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
fstp qword[float2]

mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,len3
int 80h

call read_float
fstp qword[float3]

fld qword[float2]
fmul qword[float2]
fstp qword[d]
fild qword[x]
fmul qword[float1]
fmul qword[float3]
fsubr qword[d]
fstp qword[d]
fldz
fcomp qword[d]
fstsw ax
sahf
ja im
fld qword[d]
fsqrt
fstp qword[d]

fld qword[float2]
fchs
fadd qword[d]
fdiv qword[float1]
fstp qword[d1]
fild qword[y]
fdivr qword[d1]

call print_float
ffree ST0
ffree ST1

fld qword[float2]
fchs
fsub qword[d]
fdiv qword[float1]
fstp qword[d1]
fild qword[y]
fdivr qword[d1]

call print_float
ffree ST0

mov eax,1
mov ebx,0
int 80h

im:
mov eax,4
mov ebx,1
mov ecx,msg4
mov edx,len4
int 80h

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

print_newline:
pusha
mov eax, 4
mov ebx, 1
mov ecx, newline
mov edx, 1
int 80h
popa
ret


