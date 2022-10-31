#Excersie - Vi?t ch??ng tình tìm s? nguyên l?n nh?t trong m?ng

.data
A: .word 6,7,9,12,9,1,0,5,20,6,8,2
.text
		la $a0, A
		li $s0, 0
		add $s1, $s0, $s0
		add $s2, $s1, $s1
		add $a1, $s2, $a0
		
loop1:
 		add $t0, $a1, $zero
 		addi $a1, $a1, 4
	
	  