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
j : resw 1
x: resw 1
y: resw 1
cnt: resw 1

ii: resw 1

k: resw 1
kk: resw 1


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

	call remove
	call printdel

exit :
	mov eax, 1
	mov ebx, 0
	int 80h


deleteword:
	pusha	
	mov cx, word[y]
	inc cx
	inc cx
	mov word[k],cx
	mov word[cnt], 0
		
dl_loop:
	mov cx, word[k]
	cmp cx, word[n]
	je end_dl_loop
	
	
	mov ebx, str
	movzx eax, word[x]
	mov cl, byte[ebx+eax]

	movzx eax, word[k]		
	mov dl, byte[ebx+eax]

	cmp cl, dl
	jne Continue2
	

	
	inc word[k]
	inc word[x]
	inc word[cnt]


	mov cx, word[j]
	sub cx, word[i]
	inc cx


;;
	;mov cx, word[k]
	mov word[num], cx
	call print_num
;;	
		
	
;;
	mov cx, word[cnt]
	mov word[num], cx
	call print_num
;;	

	cmp cx, word[cnt]
	jne Cont5


	mov ebx, str
	movzx eax, word[k]
	
	mov cl, byte[ebx+eax]

dcheck1:
	cmp cl, 32
	je dContinue
dcheck2: 
	cmp cl, 46
	je dContinue


; not full word

wloop1:
		mov ebx, str
		movzx eax, word[k]
		mov cl, byte[ebx+eax]
		cmp cl, 32
		je dend_cont2
		
		mov cx, word[n]
		cmp word[k], cx
		je end_dl_loop
		
			inc word[k]
			jmp wloop1
dend_cont2:
	inc word[k]
	mov cx, word[i]
	mov word[x],cx
	mov word[cnt],0
	jmp dl_loop
	



Cont5:
	inc word[k]
	mov cx,word[i]
	mov word[x],cx
	mov word[cnt],0
	jmp dl_loop
	




dContinue:
	;found word
	
	mov cx, word[i]
	mov word[x], cx
	
	mov cx, word[k]
	dec cx
	mov word[kk], cx
		
wloop:
	mov cx, word[x]
	cmp cx, word[y]
	ja end_wloop
	
	mov ebx, str
	movzx eax, word[kk]
	
	mov byte[ebx+eax], 10
	dec word[kk]
	inc word[x]
	jmp wloop		
			
end_wloop:
	inc word[k]
	mov cx, word[i]
	mov word[x], cx
	mov word[cnt],0
	jmp dl_loop	
	
	
		
	
	

Continue2:

	mov ebx, str
	movzx eax, word[k]
	mov cl, byte[ebx+eax]
	cmp cl, 32
	je end_cont2
		inc word[k]
	
		mov cx,word[n]
		cmp word[k],cx
	
		je end_dl_loop
	
		jmp Continue2
end_cont2:
	inc word[k]
	mov cx, word[i]
	mov word[x],cx
	mov word[cnt],0
	jmp dl_loop


end_dl_loop:
	
	popa
	ret

remove:
	pusha
	mov word[i],0
	mov word[j],0
remove_loop:
	mov cx,word[j]
	cmp cx, word[n]
	je end_rm_loop
	
	mov ebx, str
	movzx eax, word[j]
	
	mov cl,byte[ebx+eax]
check1:
	cmp cl, 32
	je Continue1
check2: 
	cmp cl, 46
	je Continue1
	
	inc word[j]
	jmp remove_loop
	
Continue1:
	mov cx, word[i]
	mov word[x],cx
	
	mov cx, word[j]
	dec cx
	mov word[y],cx	
	
	
	
	call deleteword
	
	mov cx, word[j]
	add cx, 1
	mov word[j],cx
	mov word[i],cx	
	
	jmp remove_loop
	mov byte[tmp],cl	

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



printdel :
	pusha
	mov word[i], 0
printdel_loop :
	
	mov cx, word[i]
	cmp word[n],cx 
	je end_printd

	mov ebx, str
        movzx eax, word[i]

        mov cl, byte[ebx+eax]
	mov byte[tmp], cl
;;spaces
;	cmp byte[tmp], 32
;	jne c1 
;	cmp cl, 32
;	jne c1	
;	jmp cont2
;
;c1:
;;
	
	cmp cl, 10
	je cont2
;;	mov byte[tmp], cl

	mov eax, 4
	mov ebx, 1
	mov ecx, tmp
	mov edx, 1
	int 80h

cont2:
	inc word[i]
	jmp printdel_loop

end_printd:
	call printnewline
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


printnewline :
	pusha
	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
	int 80h
	popa 
	ret
