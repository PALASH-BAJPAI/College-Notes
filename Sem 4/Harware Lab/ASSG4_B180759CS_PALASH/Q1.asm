section .data
newline : db 0Ah
zero : db '0'
space : db ' '

section .bss
str : resb 500
n : resw 1
i : resw 1
tmp : resb 1
cnta : resw 1
cntd : resw 1
cnts : resw 1
cntw : resw 1
lcnt : resw 1
num : resw 1
count : resw 1
dig : resb 1

section .text
global _start

_start :

call read

cmp word[n], 0
jne countcall
mov word[num], 0
call print_num
call print_num
call print_num
call print_num
jmp exit

countcall :
call counter

mov cx, word[cnta]
mov word[num], cx
call print_num

mov cx, word[cntd]
mov word[num], cx
call print_num

mov cx, word[cnts]
mov word[num], cx
call print_num

mov cx, word[cntw]
mov word[num], cx
call print_num

exit :
	mov eax, 1
	mov ebx, 0
	int 80h

read :
	pusha
	mov word[n], 0
read_loop :
	mov eax, 3
	mov ebx, 0
	mov ecx, tmp
	mov edx, 1
	int 80h

	cmp byte[tmp], 10
	je end_read

	mov ebx, str
        movzx eax, word[n]
	mov cl, byte[tmp]
        mov byte[ebx+eax], cl

	inc word[n]
	jmp read_loop

end_read :
	mov ebx, str
	movzx eax, word[n]
	mov byte[ebx+eax], 0
	popa
	ret
 	
counter :
	pusha
	mov word[cnta], 0
	mov word[cntd], 0
	mov word[cnts], 0
	mov word[cntw], 0
	mov word[i], 0
	mov word[lcnt], 0

count_loop :
	mov ebx, str
	movzx eax, word[i]
	mov cl, byte[ebx+eax]
	
	cmp cl, 0
	je end_counter

	cmp cl, 32
	jne letter

	cmp word[lcnt], 0
	jne found_word
	jmp alphabet

found_word : 

	mov word[lcnt], 0
	inc word[cntw]
	jmp special

letter :
	 inc word[lcnt]

alphabet:
	;alphabet
	cmp cl, 65
	jb digit

checkz:	
	cmp cl, 122
	ja digit

checkA_Z :
	cmp cl, 90
	ja checka_z
	inc word[cnta]
	jmp continue

checka_z :
	cmp cl, 97
	jb digit
	inc word[cnta]
	jmp continue

digit :
	cmp cl, 48
	jb special

	cmp cl, 57
	ja special
	inc word[cntd]
	jmp continue

special :
	inc word[cnts]
	
continue :
	inc word[i]
	jmp count_loop
	
end_counter :
	dec eax
	mov cl, byte[ebx+eax]
	cmp cl, 32
	je end
	inc word[cntw]	
end :
	popa
	ret
	

print_num :
	pusha
	mov byte[count], 0
	cmp word[num], 0
	je print0
		
extract_loop : 
	cmp word[num], 0
	je print
	mov ax, word[num]
	mov dx, 0
	mov bx, 10
	div bx
	push dx
	inc byte[count]
	mov word[num], ax
	jmp extract_loop

print :
	cmp byte[count], 0
	je end_print_num
	dec byte[count]
	pop dx
	add dl, 30h
	mov byte[dig], dl
	
	mov eax, 4
	mov ebx, 1
	mov ecx, dig
	mov edx, 1
	int 80h

	jmp print

print0 :
        mov eax, 4
        mov ebx, 1
        mov ecx, zero
        mov edx, 1
        int 80h

end_print_num :
	mov eax, 4
        mov ebx, 1
        mov ecx, newline
        mov edx, 1
        int 80h
	popa
	ret

printnewline :
	pusha
	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
	int 80h
	popa 
	ret













