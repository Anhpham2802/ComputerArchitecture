# 2. Nh?p vào xâu ký t?. In ra các ký t? khác nhau có trong xâu
.data
	tmp: .space 64					#khai bao khong gian luu tru 
	inputString: .space 100
	INPUT_STRING_MESSAGE: .asciiz "Enter a string (under 64 character): "
	RESULT:	  .asciiz "CAC KY TU KHAC NHAU TRONG CHUOI: "
.text
main:
#--------------------------------------------------------------------------------------------
#	Nhan vao 1 xau tu nguoi dung
#--------------------------------------------------------------------------------------------
getString:
	li $v0, 54
	la $a0, INPUT_STRING_MESSAGE	 	#hien thi hop thoai
	la $a1, inputString
	la $a2, 51
	syscall
	
	li $t0, 0							
	li $t1, 0							# i=0
	la $s0, inputString					#load dia chi cua chuoi nhap vao
	la $s1, tmp							#load dia chi cua chuoi luu cac chu cai khac nhau
	
	li $a0, '\0'
	li $a1, '\n'
loop1:
	add $t5, $s1, 0				# $t5 = ?ia chi tmp
	add $t6, $s1, $t1			# tmp + i = $t6
	lb $t2, 0($s0)				#load chu cai ? dia chi $s0 vao $t2
	beq $t2, $a1, end_loop1		# ki tu xuong dong thi ket thuc
loop2:
	lb $t3, 0($t5)				#load chu cai o dia chi $t5 vao $t3
	beq $t2, $t3, continue_loop1	#neu chu cai da ton tai trong tmp thi tiep tuc lap, nugoc lai thi them vao
	add $t5, $t5, 1				# tang con tro len 1 (cong them 1 o nh?)
	bgt $t5, $t6, end_loop2		# address(tmp[i]) == tmp + length(tmp)  
	j loop2
end_loop2:
	sb $t2, 0($t6)				#luu ki tu dang xet vao cuoi chuoi tmp
	add $t1, $t1, 1
	j loop1
continue_loop1:
	add $s0, $s0, 1
	j loop1
end_loop1:
	add $t6, $s1, $t1
	sb $a0, 0($t6)
print:
	li	$v0, 4
	la $a0, RESULT
	syscall
	
	li	$v0, 4
	add $a0, $s1, 0
	syscall
