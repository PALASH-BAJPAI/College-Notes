	.data
prompt:	.asciiz "Enter the number: "
str1:	.asciiz "the answer is: "
str2:	.asciiz "YES"
str3:	.asciiz "NO"
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
	move	$s1, $v0
	li $t0,0
	li $s3,0
	# print str1
	li	$v0, 4
	la	$a0, str1
	syscall
loop:	
	add $t0,$t0,1
	div $s0,$s0,10
	bne $s0,0,loop
	add $s0,$s1,0
loop1:
	rem $t1,$s1,10
	div $s1,$s1,10
	li $t2,0
	li $t3,1
loop2:
	beq $t2,$t0,endloop2
	mul $t3,$t3,$t1
	add $t2,$t2,1
	b loop2
endloop2:
	add $s3,$s3,$t3
	bne $s1,0,loop1
beq $s3,$s0,ans
ans1:
	li	$v0, 4
	la	$a0, str3
	syscall
	li	$v0,10		# Code for syscall: exit
	syscall
ans:
	li	$v0, 4
	la	$a0, str2
	syscall
	li	$v0,10		# Code for syscall: exit
	syscall
	