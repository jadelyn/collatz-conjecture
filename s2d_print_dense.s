##### Variables #####
.data
# Header for dense matrix
head:		.asciiz	"  -----0----------1----------2----------3----------4----------5----------6----------7----------8----------9-----\n"

##### print_dense function code #####
.text
# print_dense will have 3 arguments: $a0 = address of dense matrix, $a1 = matrix width, $a2 = matrix height
print_dense:
	### YOUR CODE HERE ###
	addi $sp $sp -16 # save space for three words
	sw $ra 4($sp) # save the return address
	sw $s0 8($sp)
	sw $s1 12($sp)
	sw $a0 0($sp) # NEED TO KEEP THE ORIGINAL ARGUMENT
	la $a0 head # load the head
	jal print_str # print the head
	lw $a0 0($sp)
	add $s0 $0 $a1
	add $s1 $0 $a2
	sll $s0 $s0 2 # width * 4
	sll $s1 $s1 2 # height * 4
	add $t0 $0 $0 # $t0 = 0
	add $t2 $0 $0 # $t2 = 0 ; j = 0
	add $t5 $0 $0  # $t5 = 0

	#### FIRST FOR LOOP #####
	firstFor:
		slt $t1 $t0 $s1 # set $t1 to 1 if $t0 < $a2 (i < height)
		beq $t1 $0 final # stop loop because $t0 > $a2
		sw $a0 0($sp) #KEEP ORIGINAL ARGUMENT
		add $a0 $t5 $0 # $a0 = COUNTER = $t0
		jal print_int # print integer in $a0
		jal print_space
		lw $a0 0($sp) # load original argument back in

	#### SECOND FOR LOOP #####
	secondFor:
		slt $t3 $t2 $s0 # set $t3 to 1 if $t2 < $a1 (j < WIDTH)
		beq $t3 $0 exitFirst
		mult $t0 $a1 # $t0 * $a1 --> i * width
		mflo $t4
		add $t4 $t4 $t2 # width * y + x
		sw $a0 0($sp)
		add $a0 $a0 $t4 # arr = arr + width * x + y
		lw $a0 0($a0)
		jal print_intx# print
		jal print_space
		lw $a0 0($sp)
		addi $t2 $t2 4 # increment counter
		j secondFor

	exitFirst:
		sw $a0 0($sp)
		jal print_newline
		lw $a0 0($sp)
		addi $t0 $t0 4 # increment counter
		addi $t5 $t5 1 # INCREMEnt ROW counter
		add $t2 $0 $0
		j firstFor

	final:
		lw $ra 4($sp)
		lw $s0 8($sp)
		lw $s1 12($sp)
		addi $sp $sp 16
		jr $ra
