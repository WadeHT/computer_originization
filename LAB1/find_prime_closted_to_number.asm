.data
	inputnumber: .asciiz"pls enter a number : **** user input : "
	prime: .asciiz "\nnearest prime number is: "
.text
.globl main
main:
	#print"pls enter a number : **** user input : "
	li $v0, 4
	la $a0, inputnumber
	syscall
	#scan number
	li $v0, 5
	syscall
	addi $s0, $v0, 0#save number
	#Find nearest number (Bigger)
	addi $s1, $s0, 1
	while0:
	addi $a0, $s1, 0
	jal checkPrime
	bne $v0, 0, Exit0
		addi $s1, $s1, 1
	j while0
	Exit0:
	li $v0, 4
	la $a0, prime
	syscall
	li $v0, 1
	addi $a0, $s1, 0
	syscall
	#Find nearest number (Less)
	subi $s1, $s0, 1
	while1:
	addi $a0, $s1, 0
	jal checkPrime
	bne $v0, 0, Exit1
		subi $s1, $s1, 1
	j while1
	Exit1:
	li $v0, 4
	la $a0, prime
	syscall
	li $v0, 1
	addi $a0, $s1, 0
	syscall
	li $v0, 10
	syscall
checkPrime:
	addi $t0, $zero, 2
	while0_cP:
	mul $t1, $t0, $t0
	bgt $t1, $a0, Exit0_cP
		div $t1, $a0, $t0
		mul $t1, $t1, $t0
		bne $a0, $t1, Else0_cP0
			addi $v0, $zero, 0
			jr $ra
		Else0_cP0:
		addi $t0, $t0, 1
	j while0_cP
	Exit0_cP:
	addi $v0, $zero, 1
	jr $ra
		
	
