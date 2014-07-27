# CS61C Sp14 Project 1-2
# Task A: The Collatz conjecture

.globl main
.include "collatz_common.s"

main:
	jal read_input			# Get the number we wish to try the Collatz conjecture on
	move $a0, $v0			# Set $a0 to the value read
	la $a1, collatz_iterative	# Set $a1 as ptr to the function we want to execute
	jal execute_function		# Execute the function
	li $v0, 10			# Exit
	syscall
	
# --------------------- DO NOT MODIFY ANYTHING ABOVE THIS POINT ---------------------

# Returns the stopping time of the Collatz function (the number of steps taken till the number reaches one)
# using an ITERATIVE approach. This means that if the input is 1, your function should return 0.
#
# The initial value is stored in $a0, and you may assume that it is a positive number.
# 
# Make sure to follow all function call conventions.
collatz_iterative:
	li $t0 0 # $t0 = 0; $t0 is used as the counter
	addi $t1 $0 3 # $t1 = 3
	addi $t2 $0 1 # $t2 = 1
	start:
		beq $t2 $a0 end # if $a0 == 1, go to end
		addi $t0 $t0 1 # $t += 1; increment counter
		andi $t3 $a0 0x00000001 # $t3 = the last digit of $a0
		bne $t3 $0 odd # if $t1 is not equal to zero, $a0 is currently odd
		j even # otherwise, jump to even
	even:
		srl $a0 $a0 1 # shift $a0 right by 1 to divide by 2
		j start # restart the iteration
	odd:
		mult $a0 $t1 # 3 * $a0
		mflo $a0 # $a0 = 3 * $a0
		addi $a0 $a0 1 # $a0 += 1
		j start # restart the iteration
	end:
		add $v0 $0 $t0 # $v0 = $t0
		jr $ra # return to caller
