section .data
newline : db 0Ah
zero : db '0'
space : db ' '
m1: db "Enter String: ",0Ah
s1:equ $-m1
m2: db "Not Palindrome",0Ah
s2: equ $-m2
m3: db "Palindrome",0Ah
s3: equ $-m3 

section .bss
str : resb 500
n : resw 1
i : resw 1
j : resw 1
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
	call check_Palindrome


exit :
	mov eax, 1
	mov ebx, 0
	int 80h


check_Palindrome:
	pusha
	mov word[i],0
	mov cx, word[n]
	dec cx
	mov word[j],cx

cP_loop:
	mov cx,word[i]
	cmp cx, word[j]
	jnb end_cP_loop
	
	mov ebx, str
	movzx eax, word[i]
	
	mov cl,byte[ebx+eax]
	mov byte[char],cl

;;
;;	mov byte[tmp],cl
;;	call printchar
;;

	movzx eax, word[j]
	mov cl, byte[ebx+eax]
;;
;;	mov byte[tmp],cl
;;	call printchar
;;


	cmp cl, byte[char]
	je Continue1

	mov eax, 4
	mov ebx, 1
	mov ecx, m2
	mov edx, s2
	int 80h
	popa 
	ret
		
Continue1:
	inc word[i]
	dec word[j]
	jmp cP_loop		
		
end_cP_loop:

	mov eax, 4
	mov ebx, 1
	mov ecx, m3
	mov edx, s3
	int 80h
		
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


printnewline :
	pusha
	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
	int 80h
	popa 
	ret

printchar:
	pusha
	mov eax, 4
	mov ebx, 1
	mov ecx, tmp
	mov edx, 1
	int 80h
	call printnewline
	popa
	ret	



