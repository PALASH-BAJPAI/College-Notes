	.data
prompt:	.asciiz "Enter the first integer: "
prompt1: .asciiz "Enter the second integer: "
str1:	.asciiz "the answer are: "
newline: .asciiz	"\n"
	.globl	main
	
	.text
main:
	li	$v0, 4
	la	$a0, prompt
	syscall
	li	$v0, 5
	syscall
	move 	$s0, $v0
	li	$v0, 4
	la	$a0, prompt1
	syscall
	li	$v0, 5
	syscall
	move 	$s1, $v0
	add $s0,$s0,1
	# print str1
	li	$v0, 4
	la	$a0, str1
	syscall
loop:	
	beq $s0,$s1,endloop
	li $t1,2
loop1:
	beq $s0,$t1,endloop11
	rem $t2,$s0,$t1
	beq $t2,0,endloop1 
	add $t1,$t1,1
	b loop1
endloop1:
	add $s0,$s0,1
	b loop
endloop11:
	li	$v0, 1
	move	$a0, $s0
	syscall
	li	$v0, 4
	la	$a0, newline
	syscall
	add $s0,$s0,1
	b loop
endloop:
	li	$v0,10		# Code for syscall: exit
	syscall