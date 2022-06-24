section .data
msg1: db 'Enter the angle: ',0Ah
size1: equ $-msg1
msg2:db 'sinx by calculation is : '
size2:equ $-msg2
msg3:db 'sinx by FSQRT is : '
size3:equ $-msg3
nwl: db 10

format1: db "%lf",0
format2: db "%lf",10
format3: db "%ld",0

section .bss
n: resw 1
nn: resb 1
float1:resq 1
float2: resq 1
sum : resq 1
n2: resq 1
farr: resq 100
i: resb 1
j: resb 1
temp: resb 1
mean: resq 1
med: resq 1
std: resq 1
var: resq 1
x: resq 1
y: resq 1
e: resq 1
m: resw 1
aa: resw 1
ans: resq 1
v: resb 1
res: resw 1
check: resq 1 
section .text
global main
extern scanf
extern printf

main:
mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,size1
int 80h

call read_float
fst qword[n2]
fst qword[x]

sinfn:
fstp qword[ans]
fld qword[x]
fmul st0
fmul qword[x]
;mov byte[nn],3
;call fact
mov word[res],6
fidiv word[res]
fchs
fadd qword[x]
fstp qword[ans]
fld qword[x]
fmul st0
fmul st0
fmul qword[x]
;mov byte[nn],5
;call fact
mov word[res],120
fidiv word[res]
fadd qword[ans]
fstp qword[ans]
fld qword[x]
fmul st0
fmul st0
fmul qword[x]
fmul qword[x]
fmul qword[x]
;mov byte[nn],5
;call fact
mov word[res],5040
fidiv word[res]
fchs
fadd qword[ans]
fstp qword[ans]

endwhile:
mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,size2
int 80h
fld qword[ans]
call print_float

mov eax,4
mov ebx,1
mov ecx,nwl
mov edx,1
int 80h

mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,size3
int 80h

fld qword[x]
fsin
call print_float

exit:
mov eax,1
mov ebx,0
int 80h 






read_int:
push ebp
mov ebp,esp
sub esp,2
lea eax,[ebp-2]
push eax
push format3
call scanf
mov ax,word[ebp-2]
mov word[n],ax
mov esp,ebp
pop ebp
ret

read_float:
push ebp
mov ebp,esp
sub esp,8
lea eax,[esp]
push eax
push format1
call scanf
fld qword[ebp-8]
mov esp,ebp
pop ebp
ret

print_float:
push ebp
mov ebp, esp
sub esp, 8
fst qword[ebp-8]
push format2
call printf
mov esp, ebp
pop ebp
ret   

fact:
pusha
mov word[res],1
mov byte[v],1
fact2:
mov cl,byte[nn]
cmp byte[v],cl
ja endfact
mov ax,word[res]
movzx bx,byte[v]
mul bx
inc byte[v]
mov word[res],ax
jmp fact2

endfact:
popa
ret

