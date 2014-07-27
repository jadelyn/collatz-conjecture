# CS61C Sp14 Project 1-2
# Task A: The Collatz conjecture

.globl main
.include "collatz_common.s"

main:
	jal read_input			# Get the number we wish to try the Collatz conjecture on
	move $a0, $v0			# Set $a0 to the value read
	la $a1, collatz_recursive	# Set $a1 as ptr to the function we want to execute
	jal execute_function		# Execute the function
	li $v0, 10			# Exit
	syscall
	
# --------------------- DO NOT MODIFY ANYTHING ABOVE THIS POINT ---------------------

# Returns the stopping time of the Collatz function (the number of steps taken till the number reaches one)
# using an RECURSIVE approach. This means that if the input is 1, your function should return 0.
#
# The current value is stored in $a0, and you may assume that it is a positive number.
#
# Make sure to follow all function call conventions.
collatz_recursive:
	start:
		addi $sp $sp -8 # save space for two words
		sw $ra 4($sp) # save return address
		sw $s0 0($sp) # save $s0
		addi $t0 $0 1 # $t0 = 1
		addi $t1 $0 3 # $t1 = 3
		add $s0 $0 $0 # $s0 = 0
		beq $a0 $t0 fin # if $a0 = $t0 = 1, goto fin
		andi $t3 $a0 0x00000001 # $t0 = last digit of $a0
		bne $t3 $0 odd # if $t3 = 1, goto odd, otherwise continue to even
	even:
		srl $a0 $a0 1 # $a0 = $a0 / 2
		jal collatz_recursive # collatz_recursive($a0)
		add $s0 $v0 $0 # $s0 = collatz_recursive($a0)
		addi $s0 $s0 1 # $s0 += 1
		j fin # jump to fin
	odd:
		mult $a0 $t1 # $a0 * 3
		mflo $a0 # $a0 = $a0 * 3
		addi $a0 $a0 1 # $a0 += 1
		jal collatz_recursive # collatz_recursive($a0)
		add $s0 $v0 $0 # s0 += collatz_recursive($a0)
		addi $s0 $s0 1 # $s0 += 1
	fin:
		add $v0 $0 $s0 # $v0 = $s0
		lw $s0 0($sp) # restore $s0
		lw $ra 4($sp) # restore return address
		addi $sp $sp 8 $ # pop the stack frame
		jr $ra # return to caller
		