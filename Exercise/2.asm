#Exercise 1 - Hi?n th? hình tam giác nghiêng trái

.text
	li $s0, 1	#i
	li $s1, 1	#j
main:
	li $v0, 5	#nhap so luu vao v0
	syscall
	
	add $v1, $v0, $zero	#gan so nguyen vao v1
	
loop1:	bgt $s0, $v1, endloop1	#i >= v1 thi enloop1
loop2:	bgt $s1, $s0, endloop2	#j >= i thif enloop2
		
	li 	$v0, 1			
	add $a0, $s1, $zero	#in s? nguyên
	syscall
	
	li 	$v0, 11
	li 	$a0, ' '
	syscall
	
	addi $s1, $s1, 1
	j loop2

endloop2:
	li 	$v0, 11
	li 	$a0, '\n'
	syscall
	
	li $s1, 1
	
	addi $s0, $s0 , 1
	
	j loop1
endloop1:
