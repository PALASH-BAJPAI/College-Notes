section .data
format1: db "%lf",0
format2: db "Multiplication is : %lf",10
format3: db "%d", 0
msg1: db "Enter X Coordinate : "
len1: equ $-msg1
msg2: db "Enter Y Coordinate : "
len2: equ $-msg2
msg3: db "Coordinate lies in the First quadrant",10
len3: equ $-msg3
msg4: db "Coordinate lies in the Second quadrant",10
len4: equ $-msg4
msg5: db "Coordinate lies in the Third quadrant",10
len5: equ $-msg5
msg6: db "Coordinate lies in the Forth quadrant",10
len6: equ $-msg6
msg7: db "No such Quadrant Exists",10
len7: equ $-msg7

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
fstp qword[float2]

fldz
fcomp qword[float1]
fstsw ax
sahf
je level
fldz
fcomp qword[float2]
fstsw ax
sahf
je level

fldz
fcomp qword[float1]
fstsw ax
sahf
jb level1
fldz

fldz
fcomp qword[float2]
fstsw ax
sahf
jb second
jmp third

level1:
fldz
fcomp qword[float2]
fstsw ax
sahf
jb first
jmp forth

first:
mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,len3
int 80h
jmp EXIT

second:
mov eax,4
mov ebx,1
mov ecx,msg4
mov edx,len4
int 80h
jmp EXIT

third:
mov eax,4
mov ebx,1
mov ecx,msg5
mov edx,len5
int 80h
jmp EXIT

forth:
mov eax,4
mov ebx,1
mov ecx,msg6
mov edx,len6
int 80h
jmp EXIT

level:
mov eax,4
mov ebx,1
mov ecx,msg7
mov edx,len7
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

