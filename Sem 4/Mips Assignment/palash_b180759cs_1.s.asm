	.data
prompt:	.asciiz "Enter the number: "
str1:	.asciiz "the answer is: "
newline: .asciiz	" "
	.globl	main
	
	.text
main:
	li	$v0, 4
	la	$a0, prompt
	syscall
	li	$v0, 5
	syscall
	move 	$s0, $v0
	sub $s0,$s0,2
	li $t0,1
	li $t1,1
	# print str1
	li	$v0, 4
	la	$a0, str1
	syscall
	li	$v0, 1
	move	$a0, $t0
	syscall
	li	$v0, 4
	la	$a0, newline
	syscall
	li	$v0, 1
	move	$a0, $t1
	syscall
	li	$v0, 4
	la	$a0, newline
	syscall
loop:	
	beq $s0,0,endloop
	add $t2,$t1,$t0
	add $t0,$t1,0
	add $t1,$t2,0
	add $s1,$t2,0
	li	$v0, 1
	move	$a0, $s1
	syscall
	li	$v0, 4
	la	$a0, newline
	syscall
	sub $s0,$s0,1
	b loop
endloop:
	li	$v0,10		# Code for syscall: exit
	syscall