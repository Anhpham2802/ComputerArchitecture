.eqv SEVENSEG_LEFT    0xFFFF0010	# Dia chi cua den led 7 doan trai.
#     Bit 0 = doan a;
#     Bit 1 = doan b; ... 
#     Bit 7 = dau .
.eqv SEVENSEG_RIGHT   0xFFFF0011	# Dia chi cua den led 7 doan phai
.text
main:

	la 	$t2, 10
	li	$v0, 12
	syscall 
	
	div $v0, $t2
	mfhi $t3	#so hang don vi
	mflo $t5
	div $t5, $t2
	mfhi $t4	#so hang chuc

switch1:
	beq $t3, 0, zero1
	beq $t3, 1, ichi1
	beq $t3, 2, ni1
	beq $t3, 3, san1
	beq $t3, 4, yon1
	beq $t3, 5, go1
	beq $t3, 6, roku1
	beq $t3, 7, nana1
	beq $t3, 8, hachi1
	beq $t3, 9, kyuu1
switch2:
	beq $t4, 0, zero2
	beq $t4, 1, ichi2
	beq $t4, 2, ni2
	beq $t4, 3, san2
	beq $t4, 4, yon2
	beq $t4, 5, go2
	beq $t4, 6, roku2
	beq $t4, 7, nana2
	beq $t4, 8, hachi2
	beq $t4, 9, kyuu2

# hang don vi
zero1:	
	li    $a0,  0x3f               # set value for segments
	jal   SHOW_7SEG_LEFT          # show
	j switch2 
ichi1:	
	li    $a0,  0x06               # set value for segments
	jal   SHOW_7SEG_LEFT          # show
	j switch2 
ni1:	
	li    $a0,  0x5b               # set value for segments
	jal   SHOW_7SEG_LEFT          # show
	j switch2 
san1: 
	li    $a0,  0x4f               # set value for segments
	jal   SHOW_7SEG_LEFT          # show
	j switch2 
yon1:
	li    $a0,  0x66               # set value for segments
	jal   SHOW_7SEG_LEFT          # show
	j switch2 
go1:
	li    $a0,  0x6d               # set value for segments
	jal   SHOW_7SEG_LEFT          # show
	j switch2 
roku1:
	li    $a0,  0x7d               # set value for segments
	jal   SHOW_7SEG_LEFT          # show
	j switch2 
nana1:
	li    $a0,  0x07               # set value for segments
	jal   SHOW_7SEG_LEFT          # show
	j switch2 
hachi1:
	li    $a0,  0x7f               # set value for segments
	jal   SHOW_7SEG_LEFT          # show
	j switch2 
kyuu1:
	li    $a0,  0x6f               # set value for segments
	jal   SHOW_7SEG_LEFT          # show
	j switch2 

# hang chuc	
zero2:	
	li    $a0,  0x3f              # set value for segments
	jal   SHOW_7SEG_RIGHT         # show  
	j exit 
ichi2:	
	li    $a0,  0x06              # set value for segments
	jal   SHOW_7SEG_RIGHT         # show  
	j exit	
ni2:	
	li    $a0,  0x5b              # set value for segments
	jal   SHOW_7SEG_RIGHT         # show    
	j exit 
san2:
	li    $a0,  0x4f              # set value for segments
	jal   SHOW_7SEG_RIGHT         # show    
	j exit 
yon2:
	li    $a0,  0x66               # set value for segments
	jal   SHOW_7SEG_RIGHT          # show
	j exit 
go2:
	li    $a0,  0x6d               # set value for segments
	jal   SHOW_7SEG_RIGHT          # show
	j exit 
roku2:
	li    $a0,  0x7d               # set value for segments
	jal   SHOW_7SEG_RIGHT          # show
	j exit 
nana2:
	li    $a0,  0x07               # set value for segments
	jal   SHOW_7SEG_RIGHT          # show
	j exit  
hachi2:
	li    $a0,  0x7f               # set value for segments
	jal   SHOW_7SEG_RIGHT          # show
	j exit 
kyuu2:
	li    $a0,  0x6f               # set value for segments
	jal   SHOW_7SEG_RIGHT         # show
			
exit:     
	li    $v0, 10
	syscall
endmain:
#---------------------------------------------------------------
# Function  SHOW_7SEG_LEFT : turn on/off the 7seg
# param[in]  $a0   value to shown       # remark     $t0 changed
#---------------------------------------------------------------
SHOW_7SEG_LEFT:  
	li   $t0,  SEVENSEG_LEFT # assign port's address
	sb   $a0,  0($t0)	# assign new value
	jr   $ra
#---------------------------------------------------------------
# Function  SHOW_7SEG_RIGHT : turn on/off the 7seg
# param[in]  $a0   value to shown       # remark     $t0 changed
#---------------------------------------------------------------
SHOW_7SEG_RIGHT: 
	li   $t0,  SEVENSEG_RIGHT# assign port's address
	sb   $a0,  0($t0)	# assign new value
	jr   $ra   
	
