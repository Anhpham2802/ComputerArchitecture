# A-4
.data
Message1:	.asciiz "Nhap N: "
Message2:	.asciiz "Perfect Number < "
Message3:	.asciiz	"Have not perfect number!\n"
Message4:	.asciiz	": "
.text
main:

	li	$v0, 51
	la	$a0, Message1
	syscall
	
	beq $a1, -1, main	# Nhap lai cho den khi dung dinh dang so nguyen
	beq $a1, -3, main
	beq $a1, -2, exit
	
	add $s0, $a0, 0		# $s0 = N
	
	li $s1, 1			# j = 1
	li $s2, 0			# countPerfectNum = 0
	
loop1:			bge $s1, $s0, end_loop1	# if j < N ?
				li $t0, 1		# i = 1
				li $t1, 0		# sum = 0
		
loop2:			beq $t0, $s1, end_loop2	# i < j ?
				div $s1, $t0
				mfhi $t2		# $t2 = j mod i
				bnez $t2, continue_loop2
				add $t1, $t1, $t0	# sum = sum + i
continue_loop2:	add $t0, $t0, 1	# i++
				j loop2
end_loop2:		bne	$t1, $s1, continue_loop1	# sum == j ?
				add $s2, $s2, 1					# countPerfecrNumber++
				blt	$s2, 1, continue_loop1
				bgt $s2, 1, printNum
				
				li $v0, 4						# print Messsage2
				la $a0, Message2
				syscall
				
				li $v0, 1						# print N
				add $a0, $s0, 0
				syscall
				
				li $v0, 4						# print ": "
				la $a0, Message4
				syscall
				
				li $v0, 1						# print j
				add $a0, $s1, 0
				syscall
				
				li $v0, 11						# print ' '
				li $a0, ' '
				syscall
				
				j continue_loop1
printNum:		li $v0, 1						# print j
				add $a0, $s1, 0
				syscall
				
				li $v0, 11						# print ' '
				li $a0, ' '
				syscall
continue_loop1: add $s1, $s1, 1					# j++
				j loop1
end_loop1:		bnez	$s2, exit				# if countPerfectNum == 0 ?
				li $v0, 4						# print Message3
				la $a0, Message3
				syscall
exit: