section .data
format1: db "%lf",0
format2: db "Value of x3+x2-5x+9 at x is : %lf",10
format3: db "%d", 0
msg1: db "Enter the value of x : "
len1: equ $-msg1

section .bss
float1: resq 1
ans: resq 1
res: resw 1

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
fst qword[float1]
fmul ST0
fmul qword[float1]
fstp qword[ans]
fld qword[float1]
fmul ST0
fadd qword[ans]
fstp qword[ans]
fld qword[float1]
mov word[res],5
fimul word[res]
fchs
fadd qword[ans]
mov word[res],9
fiadd word[res]

call print_float

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

