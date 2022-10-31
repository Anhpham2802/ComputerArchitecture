# Kiem tra giua ky Kien Truc May Tinh - De so 6

.data
mess1:	.asciiz "Nhap so phan tu cua mang: "
mess2:	.asciiz "Nhap mang\n"
mess3:	.asciiz "Nhap phan tu thu "
mess4:	.asciiz ": "
mess5:	.asciiz "Tich lon nhat duoc tim thay la cua "
mess6:	.asciiz " va "
mess7:	.asciiz " la: "
mess8:	.asciiz "Mang chi co mot phan tu duy nhat! Tich lon nhat la: "
mess9:	.asciiz "Mang rong! Khong tim duoc gia tri max!"
mess10: .asciiz "So phan tu cua mang phai la mot so nguyen khong am! Moi nhap lai! \n"
A:	.word	0:20

#---------------------------------------------------
# $s0 : Dia chi mang A
# $s1 : So phan tu cua mang n
# $s2 : Bien chay i
# $s3 : MAX PRODUCT
# $s4 : Gia tri index hien tai
#---------------------------------------------------

.text
	add	$s2, $zero, $zero		
main:	
	li	$v0, 4					# "Nhap so phan tu cua mang: "
	la	$a0, mess1
	syscall
	
	li	$v0, 5					# Nhap so phan tu n cua mang
	syscall
	
	slti	$t1, $v0, 0				# Kiem tra neu n < 0 -> Bao loi va nhap lai
	bne	$t1, $zero, error
	
	beq	$v0, $zero, ArrayNull			# Neu n = 0 -> Nhay den ArrayNull
	
	slti	$t1, $v0, 2				# Kiem tra neu n =1 -> Nhay den OneElement
	bne	$t1, $zero, OneElement

	add	$s1, $zero, $v0				# Khi n >= 2, gan n->$s0
	
	li	$v0, 4					# "Nhap mang"
	la	$a0, mess2
	syscall
	
input:	
	slt	$t1, $s2, $s1				# i < n ? $t1 = 1 : $t1 = 0
	beq	$t1, $zero, end_input			# Neu i >= n -> Ket thuc nhap mang 
			
	li	$v0, 4					# "Nhap phan tu thu "
	la	$a0, mess3
	syscall
	
	li	$v0, 1					# In STT cua tung phan tu trong mang
	addi	$t9, $s2, 1           			#
	add	$a0, $t9, $zero 			#
	syscall
	
	li	$v0, 4					# ": "
	la	$a0, mess4
	syscall
	
	li	$v0, 5					# Nhap tung phan tu cua mang -> $v0
	syscall
	
	add	$t2, $s2, $s2				# $t2 = 4i
	add	$t2, $t2, $t2				#
	sw	$v0, A($t2)				# Phan tu nhap vao tu ban phim -> A[i]
	addi	$s2, $s2, 1				# i = i+1
	j	input				
	
end_input:
	
	la	$s0, A					# Dia chi cua mang A
	li	$s2, 0					# Bien i = 0
	li	$s3, 0					# max = 0
	sub	$t0, $s1, 1				# n-1
	j	findmaxproduct
	nop
	
findmaxproduct:

	addi	$t3,$s0,0				# Dia chi cua A[0] -> $t3
	lw	$t4,0($t3)				# Gia tri cua A[0] -> $t4
	add	$t6,$s0,4				# Dia chi cua A[1] -> $t6
	lw	$t7,0($t6) 				# Gia tri cua A[1] -> $t7
	mult 	$t4, $t7				# A[0] * A[1] 	
	mflo	$s3					# Khoi tao max ban dau A[0] * A[1] -> $s3
	move	$s4, $t4				
	move	$s5, $t7	
				
loop:
	slt	$t1, $s2, $t0				# i < n-1 ? t1 = 1 : t1 = 0
	beq	$t1, $zero, end_findmaxproduct
	add	$t2,$s2,$s2				# $t2 = 2i
	add	$t2,$t2,$t2				# $t2 = 4i
	add	$t3,$t2,$s0				# Dia chi cua A[i] -> $t3
	lw	$t4,0($t3)				# Gia tri cua A[i] -> $t4
	addi	$t5, $s2, 1				# i = i+1	
	add	$t5,$t5,$t5				# $t5 = 2(i+1)
	add	$t5,$t5,$t5				# $t5 = 4(i+1)
	add	$t6,$t5,$s0				# Dia chi cua A[i+1] -> $t6
	lw	$t7,0($t6) 				# Gia tri cua A[i+1] -> $t7
	mult 	$t4, $t7				# A[i] * A[i+1] 	
	mflo	$s1					# Lay tich duoc luu o thanh ghi lo , luu vao $s1
	slt	$s6, $s3, $s1				# max < $s1 ? $s6 = 1 : $s6 = 0
	beq	$s6, $zero, loop_continue		# Neu max > $s1 -> tang bien len 1 va tiep tuc lap 
	move	$s3, $s1				# Neu max < $s1 -> max = $s1
	move	$s4, $t4
	move	$s5, $t7
	
loop_continue:

	add	$s2, $s2, 1				# i = i+1
	j	loop
	
end_findmaxproduct:

	li	$v0, 4           			# "Tich lon nhat duoc tim thay la cua "
    	la	$a0, mess5  				
    	syscall
    	li	$v0, 1           			# i [max]
    	add	$a0, $s4, $zero  
    	syscall
    	li	$v0, 4           			# " va "
    	la	$a0, mess6  				
    	syscall
    	li	$v0, 1           			# i+1 [max]
    	add	$a0, $s5, $zero  
    	syscall
    	li	$v0, 4           			# " la: "
    	la	$a0, mess7  				
    	syscall
    	li	$v0, 1           			# max
    	add	$a0, $s3, $zero  
    	syscall
    	j	end
    	
ArrayNull:

    	li	$v0, 4           			# "Mang rong! Khong tim duoc gia tri max!"
    	la	$a0, mess9  				
    	syscall
	j	end
	
OneElement:
	
	li	$v0, 4					# "Nhap phan tu thu "
	la	$a0, mess3
	syscall
	
	li	$v0, 1					
	li	$a0, 1			
	syscall
	
	li	$v0, 4					# ": "
	la	$a0, mess4
	syscall
	
	li	$v0, 5				
	syscall
	
	add	$s3, $v0, $zero
	li	$v0, 4           			# "Mang chi co mot phan tu duy nhat! Tich lon nhat la: "
    	la	$a0, mess8  				
    	syscall
    	li	$v0, 1           			# max
    	add	$a0, $s3, $zero  
    	syscall
    	j	end
error:	
	li	$v0, 4					# "Error"
	la	$a0, mess10
	syscall
	j	main
end:	
	