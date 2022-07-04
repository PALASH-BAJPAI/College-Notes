section .data
section .data
mes1: db "Enter number of elements :", 0Ah
len1: equ $-mes1
mes2: db "Enter the array :", 0Ah
len2: equ $-mes2
mes3: db "Sorted array is:", 0Ah
len3: equ $-mes3

format1: db "%lf",0
format2: db "%lf",10

section .bss
array: resq 100
arr_size: resd 1
n: resd 1
temp: resq 1
digit: resb 1
float1: resq 1


section .text
global main:
extern scanf
extern printf

main:

mov eax, 4
mov ebx, 1
mov ecx, mes1
mov edx, len1
int 80h


call fn_get_number
mov eax,dword[n]
mov dword[arr_size],eax

mov eax, 4
mov ebx, 1
mov ecx, mes2
mov edx, len2
int 80h

pusha
call fn_input_array
popa

mov eax, 4
mov ebx, 1
mov ecx, mes3
mov edx, len3
int 80h

mov esi,0

loop1:

	cmp esi,dword[arr_size]
	jae end_loop1

mov edi,0

loop2:
	mov ebx,dword[arr_size]
	dec ebx
	cmp edi,ebx
	je end_loop2

	fld qword[array + 8*edi]
	
	fcom qword[array + 8*edi + 8]
	fstsw ax
	sahf

	jna skip_it

	fstp qword[temp]
	
	
	fld qword[array + 8*edi + 8]

	fstp qword[array + 8*edi]

	fld qword[temp]

	fstp qword[array + 8*edi + 8]


	jmp blabla

	skip_it:

	ffree ST0
	
	blabla:

	inc edi

jmp loop2

end_loop2:

inc esi

jmp loop1
end_loop1:

pusha
call fn_print_array
popa

mov eax,1
mov ebx,0
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

fn_get_number:
mov byte[digit],30h
mov dword[n],0


getting_number:

	sub byte[digit],30h

	mov eax,dword[n]
	mov ebx,10
	mul ebx
        
	movzx ecx ,byte[digit]
   	add eax,ecx

	mov dword[n],eax

	mov eax,3
	mov ebx,0
	mov ecx,digit
	mov edx,1
	int 80h
	
	cmp byte[digit],10

jne getting_number
ret



fn_input_array:

mov esi,0
input_array:

	getting_elem:

	cmp dword[arr_size],esi
	je exit_input_array

	call read_float
	fstp qword[array + 8*esi]
	
	inc esi

	jmp getting_elem


exit_input_array:
ret

fn_print_array:

mov esi,0
print_array:
	
	cmp dword[arr_size],esi
	je end_array_print

	fld qword[array + 8*esi]
	call print_float
	
	ffree ST0

	inc esi

jmp print_array

end_array_print:
ret

