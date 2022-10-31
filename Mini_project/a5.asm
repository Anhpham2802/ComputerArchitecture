.data
	Mess0 : .asciiz "Nhap so:"
	error : .asciiz "So cua ban bi le chu so khong tinh duoc!"
	error1: .asciiz "so bi am mat roi"
	Mess1: .asciiz "So nay la so may man!"
	Mess2: .asciiz "so nay khong may man"
.text
	li $v0,4
	li $t9,10 #for div
	li $t8,0 # count_char= 0
	li $t7,0 # sum_all
	li $t6,0 # sum1
	la $a0,Mess0
	syscall
	li $v0,5 # $v0 = x
	syscall
	slt $t0,$v0,$0
	bne $t0,$zero,err1
	addi $t1,$v0,0 # y = x
loop:
	beq $t1,$zero,end_loop
	div $t1,$t9
	mflo $t1 # t1 = t1/10
	mfhi $t2 # t2 = char
	add $t7,$t7,$t2
	addi $t8,$t8,1
	j loop
end_loop:
	li $t9,2
	div $t8,$t9 # check odd
	mfhi $t9 
	mflo $t0 # get haf
	bne $t9,$zero,err0 # check odd
	#if not 
	addi $t1,$v0,0 # y = x
	li $t9,10 #for div
loop1:
	beq $t0,$zero,endloop1
	div $t1,$t9
	mflo $t1
	mfhi $t2
	add $t6,$t6,$t2
	subi $t0,$t0,1
	j loop1
endloop1:
	sub $t5,$t7,$t6
	beq $t5,$t6,lucky
unlucky:
	li $v0,4
	la $a0,Mess2
	syscall
	j endMain
lucky:
	li $v0,4
	la $a0,Mess1
	syscall
	j endMain
err0:
	li $v0,4
	la $a0,error
	syscall
	j endMain
err1:
	li $v0,4
	la $a0,error1
	syscall
endMain: