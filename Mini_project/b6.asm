# B-6
.data
A: .space 100
Message1: .asciiz "Nhap so phan tu (<= 25): "
Message2: .asciiz "Nhap phan tu cho mang:  "
Message3: .asciiz "Phan tu nguyen duong nho nhat trong mang la: "
Message4: .asciiz "Khong co phan tu nao!\n"
.text
main:
	la 	$s0, A				# load address of array A
	
	li	$v0, 51
	la	$a0, Message1
	syscall
	
	beq $a1, -1, main
	beq $a1, -3, main
	beq $a1, -2, exit

	add $s1, $zero, $a0		# Length array A
	li $s4, 0				# count
	li $t0, 0				# i = 0
input_array:
	bge $t0, $s1, end_input_array
input_element:
	li	$v0, 51
	la	$a0, Message2
	syscall
	
	beq $a1, -1, input_element
	beq $a1, -3, input_element
	beq $a1, -2, exit
	
	add $t1, $t0, $t0		# 2i
	add $t1, $t1, $t1		# 4i
	add $t1, $s0, $t1		# A + 4i
	
	sw $a0, 0($t1)
	
	add $t0, $t0, 1			# i++
	j input_array
end_input_array:
	sll $t0, $s1, 2
	add $a1, $s0, $t0		# A[length]
	add $a1, $a1, -4
	j sort
after_sort:
	li $t0, 0				# i = 0
	li $s3, -1				# min = -1
	add $t1, $s1, -1		# length - 1
	sll $t1, $t1, 2			# 4(length - 1)
	add $t2, $t1, $s0		# A + 4(length -1)
loop0:	blt	$t2, $s0, end_loop0
		lw $t1, 0($t2)
		bltz	$t1, end_loop0
		add $s3, $t1, 0
		add $t2, $t2, -4
		j loop0
end_loop0:
		bltz	$s3, printKhongCoPhanTu
		li	$v0, 4
		la	$a0, Message3
		syscall
		
		li $v0, 1						# print min
		add $a0, $s3, 0
		syscall
		
		j exit
printKhongCoPhanTu:
		li	$v0, 4
		la	$a0, Message4
		syscall
		
		j exit
#--------------------------------------------------------------
#procedure sort (ascending selection sort using pointer)
#register usage in sort program
#$a0 pointer to the first element in unsorted part
#$a1 pointer to the last element in unsorted part
#$t0 temporary place for value of last element
#$v0 pointer to max element in unsorted part
#$v1 value of max element in unsorted part
#--------------------------------------------------------------
sort: 
    beq $s0,$a1,done 		#single element list is sorted
    j max 					#call the max procedure
after_max: 
    lw 	 $t0,0($a1) 		#load last element into $t0
    sw	 $t0,0($v0) 		#copy last element to max location
    sw	 $v1,0($a1) 		#copy max value to last element
    addi $a1,$a1,-4 		#decrement pointer to last element
    j    sort 			#repeat sort for smaller list
done:
    j    after_sort

#------------------------------------------------------------------------
#Procedure max
#function: fax the value and address of max element in the list
#$a0 pointer to first element
#$a1 pointer to last element
#------------------------------------------------------------------------

max:
    addi $v0,$s0,0 		#init max pointer to first element
    lw	 $v1,0($v0) 	#init max value to first value
    addi $t0,$s0,0 		#init next pointer to first
    
loop:
    beq  $t0,$a1,ret 		#if next=last, return
    addi $t0,$t0,4 		#advance to next element
    lw   $t1,0($t0) 		#load next element into $t1
    slt  $t2,$t1,$v1 		#(next)<(max) ?
    bne  $t2,$zero,loop 		#if (next)<(max), repeat
    addi $v0,$t0,0 		#next element is new max element
    addi $v1,$t1,0 		#next value is new max value
    j 	 loop 			#change completed; now repeat
    
ret:
    j after_max
exit: