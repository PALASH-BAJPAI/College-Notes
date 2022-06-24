section .bss
float1: resq 1

section .data

format1: db "%lf",0
format2: db "The area is %lf",10


section .text

global main
extern scanf
extern printf

readFloat:
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

printFloat:
	push ebp
	mov ebp, esp
	sub esp, 8
	fst qword[esp]
	push format2
	call printf
	mov esp, ebp
	pop ebp
	ret

main:
	call readFloat
	fstp qword[float1]; moves word and clears ST0	

	fld qword[float1]
	fldpi	
	fmul ST1
	fmul ST1
	call printFloat	
	ffree ST0
	ffree ST1

exit:
	mov eax, 1
	mov ebx, 0
	int 80h

