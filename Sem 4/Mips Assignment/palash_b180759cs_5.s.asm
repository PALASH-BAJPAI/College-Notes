.data
str1: .space 50
str2: .space 50
msg1: .asciiz "Enter the string: "
msg2: .asciiz "Enter the pattern: "
msg3: .asciiz "Pattern not found."
msg4: .asciiz "pattern found at "
newline: .asciiz "\n"

.text
.globl main

main:
li $v0,4
la $a0,msg1
syscall

li $v0,8
la $a0,str1
li $a1,50
syscall

li $v0,4
la $a0,msg2
syscall

li $v0,8
la $a0,str2
li $a1,50
syscall

la $s0,str1
la $s1,str2
move $t4,$0

loop1:

lb $t0,($s0)
beq $t0,0,not_found

move $s2,$s0
move $s3,$s1

check:

lb $t2,($s2)
lb $t3,($s3)

beq $t3,10,found
bne $t2,$t3,out_check
addi $s3,$s3,1
addi $s2,$s2,1

j check

out_check:
addi $s0,$s0,1
addi $t4,$t4,1

j loop1

not_found:
li $v0,4
la $a0,msg3
syscall
j exit

found:
li $v0,4
la $a0,msg4
syscall

li $v0,1
move $a0,$t4
syscall

exit:
li $v0,10
syscall