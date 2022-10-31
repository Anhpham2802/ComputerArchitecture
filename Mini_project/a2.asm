# Câu 2: Nh?p s? nguyên d??ng N t? bàn phím, in ra màn hình dãy s? Fibonacci nh? h?n N. 

.text
	li $v0, 5
 	syscall 
 	
 	addi $v1, $v0, 0	#gán giá tr? $v0 cho $v1 
 	li $s1, 0
 	li $s2, 1
	
	li 	$v0, 1
	li	$a0, 0x001				#in giá tr? $s0 cua day so Fibonacci 
	syscall
	
	li $v0, 11
 	li $a0, ' '			#in kí t? cách
 	syscall 
	
loop: 
	bge $s3, $v1, endloop 	# s? Fibonacci >= so nhap vao thi ket thuc
	add $s3, $s2, $s1
	add $s1, $s2, $zero
	add $s2, $s3, $zero
	bge $s3, $v1, endloop 	# s? Fibonacci >= so nhap vao thi ket 
	
	li 	$v0, 1			
	add $a0, $s3, $zero		#in giá tr? $s0 cua day so Fibonacci 
	syscall
	
	li $v0, 11
 	li $a0, ' '			#in kí t? cách
 	syscall 
 	
	j loop
endloop:
