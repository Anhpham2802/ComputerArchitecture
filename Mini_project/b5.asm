# 5. Nhap mang so nguyên tu bàn phím. In ra tong các phan tu le và chia het cho 3 trong mang. 

.data
	A:word	0:100
	mess1:.asciiz "So phan tu cua mang :"
	error:.asciiz "phan tu phai lon hon 0\n"
	mess2:.asciiz "phan tu thu "
	mess3:.asciiz " la:"
	mess4:.asciiz "\n"
	mess5:.asciiz "Tong cac so le chia het cho 3 la :"
.text	
	
Nhap_so_phan_tu:
	li $v0,4 
	la $a0,mess1		# print	string
	syscall 
	
	li $v0,5			# read integer
	syscall
	
	add $t5,$t5,$v0		# luu so phan tu cua mang vào $t5 (n phan tu)
	slt $t9,$t5,$zero	# kiem tra n < 0 thì lenh duoi se nhay den nhan loi ($t5<0 thi $t9=1)
	bne $t9,$zero,loi	# $t9 = 0, khong co loi 
	j ketthuc			
	
loi:
	li $v0,4 
	la $a0,error		#in chuoi
	syscall
	
	j Nhap_so_phan_tu	#nhap lai
	
ketthuc:
	li $t1,0 			# i = 0

nhap_mang:
	beq $t1,$t5,end_nhapmang # i = n thi ket thuc vong lap
	
	li $v0,4 
	la $a0,mess2		#in chuoi
	syscall 
	
	li $v0,1 
	add $a0,$t1,$zero	# in i
	syscall
	
	li $v0,4 
	la $a0,mess3		#in chuoi
	syscall
	
	li $v0,5			# nhan 1 so nguyen nhap tu ban phim
	syscall
	
	sll $t2,$t1,2		# dich trai i sang 2 bit ($t1*4 = $t2)
	sw	$v0,A($t2)		# luu gia tri so vua nhap vao A[i]
	
	li $v0,4 
	la $a0,mess4		#in chuoi
	syscall 
	
	addi $t1,$t1,1		# i++
	j nhap_mang
	
end_nhapmang:
	li $t9,0 	#sum
	li $t1,0 	# i=0
	la $a0,A	#load dia chi mang A ( A[0] )
	li $t8,3 
	j loop
	
loop_up:
	addi $t1,$t1,1
	
loop:
	beq $t1,$t5,endloop		# i=n => endloop
	sll $t2,$t1,2			# $t2 = i*4
	add $t3,$t2,$a0			# lay dia chi A[i] luu vao $t3
	lw $t2,0($t3)			# lay gia tri A[i] luu vao $t2
	andi $t4,$t2,1			# t2 and 0001 (kiem tra phan tu le)
	beq $t4,$zero,loop_up	# phan tu chan thi tang i quay lai vong lap
	div $t2,$t8 			# A[i] / 3
	mfhi $t3				# lay phan du
	bne $t3,$zero,loop_up	# du khac 0 thi tang i quay lai vong lap
	add $t9,$t9,$t2			# sum = sum + A[i]
	j loop_up				# i++
	
endloop:
	li $v0,56 
	la $a0,mess5
	add $a1,$a1,$t9			#in sum ra man hinh
	syscall 
	
	
