.eqv MONITOR_SCREEN 0x10010000
.eqv WHITE          0x00FFFFFF
.text
	li $k0, MONITOR_SCREEN
	li $k1, 0x100100fc
	li $t0, WHITE
	li $t1, 1
	li $t2, 2
loop:
	bgt $k0, $k1, exit_loop
	div $t1, $t2
	mfhi $t3
	bne	$t3, 1, in_hang_chan
	sw 	$t0, 4($k0)
	sw 	$t0, 12($k0)
	sw 	$t0, 20($k0)
	sw 	$t0, 28($k0)
	add $k0, $k0, 32
	add $t1, $t1, 1
	j loop
in_hang_chan:
	sw	$t0, 0($k0)
	sw 	$t0, 8($k0)
	sw 	$t0, 16($k0)
	sw 	$t0, 24($k0)
	add $k0, $k0, 32
	add $t1, $t1, 1
	j loop
exit_loop: