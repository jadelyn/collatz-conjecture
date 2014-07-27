##### sparse2dense function code #####
.text
# sparse2dense will have 2 arguments: $a0 = address of sparse matrix data, $a1 = address of dense matrix, $a2 = matrix width
# Recall that sparse matrix representation uses the following format:
# Row r<y> {int row#, Elem *node, Row *nextrow}
# Elem e<y><x> {int col#, int value, Elem *nextelem}
sparse2dense:
	### YOUR CODE HERE ###
	Rows: 
		lw $t0 0($a0) #row number
		la $t1 4($a0) #address of elem ptr
		addi $t2 $t1 8 #column number 
		bne $t1 $0 Elems #if curr_Row points to an element
		j nextRow #else go to next row

	Elems: 
		lw $t4 4($t2) #value of element 
		lw $t3 0($t2) 
		mult $t0 $a2 
		mflo $t5 
		add $t5 $t5 $t3 
		mul $t5 $t5 4
		add $t5 $t5 $a1 
		sw $t4 0($t5)
		lw $t6 8($t2)
		beq $t6 $0 nextRow #if elems null go to next row  
		move $t2 $t6 
		j Elems

	nextRow:
		lw $t8 8($a0) 
		beq $t8 0 fin #if curr row is null, finish 
		lw $t8 8($a0) #next row pointer 
		move $a0 $t8 #curr_row now points to next row 
		j Rows 

	fin: 
		jr $ra 