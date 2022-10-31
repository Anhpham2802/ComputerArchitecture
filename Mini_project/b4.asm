#Bai 4b
.data
Message1: .asciiz "Nhap so phan tu: "
Message2: .asciiz "Nhap phan tu cho mang:  "
Message3: .asciiz "Tong cac phan tu am la "
Message4: .asciiz ". Tong cac phan tu duong la "
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
	bge $t0, $s0, calculate
nhapphantu:
	li	$v0, 51
	la	$a0, Message2
	syscall
	
	beq $a1, -1, nhapphantu
	beq $a1, -3, nhapphantu
	beq $a1, -2, exit
	
	add $t1, $t0, $t0		# 2i
	add $t1, $t1, $t1		# 4i
	add $t2, $s1, $t1		# A + 4i
	
	sw $a0, 0($t2)
	
	add $t0, $t0, 1			# i++
	j input
calculate:
	li $s2, 0				# tong cac phan tu am
	li $s3, 0				# tong cac phan tu duong
	li $t0, 0
		
loop:	bge $t0, $s0, print
		add $t1, $t0, $t0		# 2i
		add $t1, $t1, $t1		# 4i
		add $t2, $s1, $t1		# A + 4i
		lw $t1, 0($t2)			# A[i]
		bltz $t1, label1		# if A[i] < 0
		add $s3, $s3, $t1
		add $t0, $t0, 1			# i++
		j loop
label1:
		add $s2, $s2, $t1
		add $t0, $t0, 1			# i++
		j loop
print:
		li $v0, 4
		la $a0, Message3
		syscall
		
		li $v0, 1
		add $a0, $s2, 0
		syscall
		
		li $v0, 4
		la $a0, Message4
		syscall
		
		li $v0, 1
		add $a0, $s3, 0
		syscall
exit: