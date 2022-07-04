section .bss

farr: resq 200
n: resw 1
i: resb 1

mean1: resq 1
mean: resq 1
var: resq 1
tmp: resq 1

section .data
format3: db "%ld",0
format1: db "%lf",0
format2: db "%lf",10



section .text

global main
extern scanf
extern printf

main:
	fldz
	fld qword[var]
	fstp qword[var]
	call readn
	call read_farr
	call print_farr
	call find_mean
	call find_variance
	fld qword[var]
	call printFloat
;	call find_STD	

exit:
	mov eax, 1
	mov ebx, 0
	int 80h

readFloat:
	pusha
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
	popa
	ret
 
printFloat:
	pusha
	push ebp
	mov ebp, esp
	sub esp, 8
	fst qword[ebp-8]
	push format2
	call printf
	mov esp, ebp
	pop ebp
	popa
	ret

readn:
	push ebp
	mov ebp, esp
	sub esp, 2
	lea eax, [ebp-2]
	push eax
	push format3
	call scanf
	mov cx, word[ebp-2]
	mov word[n], cx
	mov esp, ebp
	pop ebp
	ret

read_farr:
	pusha
	mov byte[i],0
read_loop:
	mov cl,byte[i]
	cmp byte[n],cl
	je end_read_loop

	mov ebx, farr
	movzx eax,byte[i]
	call readFloat
	fst qword[ebx+8*eax]
	inc byte[i]
	jmp read_loop
			
end_read_loop:
	popa
	ret

print_farr:
	pusha
	mov word[i],0
print_loop:
	mov cx, word[i]
	cmp word[n],cx
	je end_print_loop
	
	mov ebx, farr
	movzx eax, word[i]
	fld qword[ebx+8*eax]
	call printFloat
	inc word[i]
	jmp print_loop
end_print_loop:
	popa
	ret

find_mean:
	pusha
	mov word[i],0
	fldz
mean_loop:
	mov cx, word[i]
	cmp word[n], cx
	je end_mean_loop

	mov ebx, farr
	movzx eax, word[i]
	
	fld qword[ebx+8*eax]
	fadd ST1
	
	inc word[i]
	jmp mean_loop

end_mean_loop:

	fidiv word[n]
	call printFloat	
	fst qword[mean]
	ffree ST0	
	popa
	ret

find_variance:
	pusha
	mov word[i],0
	fldz
	fst qword[var]
var_loop:
	mov cx, word[i]
	cmp word[n], cx
	je end_var_loop

	mov ebx, farr
	movzx eax, word[i]
	
	fld qword[ebx+8*eax]
	fst qword[tmp]
	fmul qword[tmp]
	fadd qword[var]
	fstp qword[var]
	
	inc word[i]
	jmp var_loop

end_var_loop:
	fld qword[mean]
	fmul qword[mean]
	fstp qword[mean1]
	
	fld qword[var]
	fidiv word[n]
	fsub qword[mean1]
	;call printFloat
	fstp qword[var]	
	popa
	ret

find_STD:
	fld qword[var]
	fsqrt 
;	call printFloat3
	ret	
	

