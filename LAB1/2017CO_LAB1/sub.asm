.data
	result: .asciiz "The result is "
	inputa: .asciiz "The number a is "
	inputb: .asciiz  "The number b is "
.text 
.globl main
main:
	#inputa
	li $v0, 4
	la $a0, inputa
	syscall
	li $v0, 5
	syscall 
	addi $t0, $v0, 0
	#inputb
	li $v0, 4
	la $a0, inputb
	syscall
	li $v0, 5
	syscall 
	addi $t1, $v0, 0
	#result=a-b
	sub $t2, $t0, $t1
	#print and store result
	li $v0, 4
	la $a0,result
	syscall
	addi $a0, $t2, 0
	li $v0, 1
	syscall
	