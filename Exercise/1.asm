#Exercise 1 - Vi?t ch??ng trình in ra các s? 2 ch? s? và ch? s? hàng ch?c + ??n v? = 10

.text 
	li $s0, 19
	
main:
	bgt $s0, 99, endmain

	li 	$v0, 1
	add $a0, $s0, $zero
	syscall
	
	li 	$v0, 11
	li $a0, ' '
	syscall
	
	addi $s0, $s0, 9
	j main
endmain: