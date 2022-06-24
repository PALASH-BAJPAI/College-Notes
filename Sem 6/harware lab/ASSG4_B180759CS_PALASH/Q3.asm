
section .text
global main
extern scanf
extern printf



print:
push ebp
mov ebp, esp
sub esp, 8
fst qword[ebp-8]
push format2
call printf
mov esp, ebp
pop ebp
ret


read:
push ebp
mov ebp, esp
sub esp, 8
lea eax, [esp]
push eax
push format1
call scanf
fld qword[ebp-8]
mov esp, ebp
pop ebp
ret

readnat:
push ebp
mov ebp, esp
sub esp , 2
lea eax , [ebp-2]
push eax
push format3
call scanf
mov ax, word[ebp-2]
mov word[num], ax
mov esp, ebp
pop ebp
ret


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


main:

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,len1
int 80h

call read_float
fstp qword[float1]
fld qword[i]


for:
fst qword[temp]
fmul qword[temp]
fcom qword[float1]
fstsw ax
sahf
ja end
fstp qword[float2]
fld qword[temp]
fadd qword[x]
jmp for

end:
fstp qword[float2]
fld qword[temp]
fsub qword[x]
call print_float
ffree st0
ffree st1
fld qword[float1]
fsqrt
call print_float



exit:
mov eax, 1
mov ebx, 0
int 80h



section .data
format1: db "%lf",0
format2: db "The square root is  %lf",10
format3: db "%d", 0
msg1: db "Enter the no : "
len1: equ $-msg1
x: dq 0.001
i: dq 0.001



section .bss
float1: resq 1
float2: resq 1
m: resq 1
num: resw 1
num2: resw 1
temp: resq 1

