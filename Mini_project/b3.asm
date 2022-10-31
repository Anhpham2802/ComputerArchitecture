#Bai 3b
.data
Message1: .asciiz "Nhap so phan tu: "
Message2: .asciiz "Nhap phan tu cho mang:   "
A: .space 1000
.text
start:
	la 	$s1, A				# load address of array A
	
	li	$v0, 51
	la	$a0, Message1
	syscall
	
	beq $a1, -1, start
	beq $a1, -3, start
	beq $a1, -2, exit
	
	add $s0, $zero, $a0		# n
	
	li $t0, 0				# i = 0

input:
	bge $t0, $s0, sort
nhapphantu:
	li	$v0, 51
	la	$a0, Message2
	syscall
	
	beq $a1, -1, nhapphantu
	beq $a1, -3, nhapphantu
	beq $a1, -2, exit
	
	add $t1, $t0, $t0		# 2i
	add $t1, $t1, $t1		# 4i
	add $t1, $s1, $t1		# A + 4i
	
	sw $a0, 0($t1)
	
	add $t0, $t0, 1			# i++
	j input
	
sort:
		li 	$t0, 0
loop1:	beq $t0, $s0, exit
		add $t1, $t0, $t0		# 2i
		add $t1, $t1, $t1		# 4i
		add $t1, $s1, $t1		# A + 4i
	
		lw 	$a0, 0($t1)			# current_min = A[i]
		bgtz $a0, findMinAndSwap
		add $t0, $t0, 1			# i++
		j loop1

findMinAndSwap:
		add $t2, $t0, 1			# j = i + 1
loop2:	beq $t2, $s0, doneloop2
		add $t3, $t2, $t2		# 2j
		add $t3, $t3, $t3		# 4j
		add $t3, $s1, $t3		# address(A + 4j) = A[i+1]
		
		lw $a1, 0($t3)			# A[i+1]
		bltz $a1, continue		# A[i+1] < 0 => continue compare A[i] with A[i+2]
		
		slt $t4, $a0, $a1		# current_min > A[i+1] ?
		bgtz $t4, continue
		sw $a1, 0($t1)			# A[i] = A[j]
		sw $a0, 0($t3)			# A[j] = A[i]
		add $a0, $a1, 0			# min = A[j]
continue:
		add $t2, $t2, 1			# j = j + 1
		j loop2
doneloop2:
		add $t0, $t0, 1			# i++
		j loop1
exit: