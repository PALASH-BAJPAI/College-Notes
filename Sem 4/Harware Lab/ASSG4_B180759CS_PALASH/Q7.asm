section .data
newline : db 0Ah
zero : db '0'
space : db ' '
m1: db "Enter String: ",0Ah
s1:equ $-m1
m2: db "Enter character to remove: ",0Ah
s2: equ $-m2
m3: db "New String: "
s3: equ $-m3 

section .bss
str : resb 500
n : resw 1
i : resw 1
tmp : resb 1
char: resb 1

num : resw 1
count : resw 1
dig : resb 1

section .text
global _start

_start :
	mov eax, 4
	mov ebx, 1
	mov ecx, m1
	mov edx, s1
	int 80h

	call read

	mov eax, 4
	mov ebx, 1
	mov ecx, m2
	mov edx, s2
	int 80h

	mov eax, 3
	mov ebx, 1
	mov ecx, char
	mov edx, 1
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, m3
	mov edx, s3
	int 80h


	call remove

exit :
	mov eax, 1
	mov ebx, 0
	int 80h
remove:
	pusha
	mov word[i],0
remove_loop:
	mov cx,word[i]
	cmp cx, word[n]
	je end_rm_loop
	
	mov ebx, str
	movzx eax, word[i]
	
	mov cl,byte[ebx+eax]
	cmp cl, byte[char]
	je Continue1

	mov byte[tmp],cl	

	mov eax, 4
	mov ebx, 1
	mov ecx, tmp
	mov edx, 1
	int 80h
		
Continue1:
	inc word[i]
	jmp remove_loop		
		
end_rm_loop:
	popa
	ret


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
