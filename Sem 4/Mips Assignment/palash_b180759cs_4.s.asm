.data
str1: .space 50
str2: .space 50
msg1: .asciiz "Enter string1: "
msg2: .asciiz "Enter string2: "
newline: .asciiz "\n"
pos: .asciiz "1"
nege: .asciiz "-1"
z: .asciiz "0"

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

loop:
lb $t0,($s0)
lb $t1,($s1)
beq $t0,0,check_eq
bgt $t0,$t1,p
blt $t0,$t1,n
addi $s0,$s0,1
addi $s1,$s1,1
j loop

check_eq:
bne $t0,0,n
b eq

p:
li $v0,4
la $a0,pos
syscall
j exit

n:
li $v0,4
la $a0,nege
syscall
j exit

eq:
li $v0,4
la $a0,z
syscall
j exit

exit:
li $v0,10
syscall