# Brigido Noguera
# Angel nosequevaina

.data
	var: .word 0
	arr: .word 2,1,6,3
	size: .word 4
.text
	la $a0,arr
	lw $a1,size
	jal bubbleSort
	jal imprimir
	
	li $v0,10
	syscall
	

swap:
	sll $t0,$a1,2	# tem = i * 4
	add $t0,$t0,$a0	# tem = tem * v
	lw $t2,0($t0)	# cargar de memoria a registro v[i]
	
	sll $t1,$a2,2	# tem = j * 4
	add $t1,$t1,$a0	# tem = tem * v
	lw $t3,0($t1)	# carga de memoria a registro v[j]
	
	sw $t2,0($t1)	# v[j] = v[i]
	sw $t3,0($t0)	# v[i] = v[j]
	jr $ra		# salto hacia la ultima llamada
	

bubbleSort:
	addi $sp, $sp,-8
	sw $ra,4($sp)
	sw $a1,0($sp)
	
	# $a0 = v, # $a1 = size
	addi $s0,$a1,-1		# s0 = size - 1 = i
	for1:
	blez $s0,exitFor1	# i = size - 1 <= 0, sal del for
	li $s1,0		# j = 0
	for2:
	bge $s1,$s0,exitFor2	# si j >= i
	
	sll $t0,$s1,2
	add $t0,$t0,$a0
	lw  $t2,0($t0)
	lw $t3,4($t0)
	ble $t2,$t3,else
	move $a1,$s1
	addi $a2,$s1,1
	jal swap
	lw $a1,0($sp)
	
	else:
	addi $s1,$s1,1
	j for2
	
	exitFor2:
	addi $s0,$s0,-1
	j for1
	
	exitFor1:
	lw $a1,0($sp)
	lw $ra,4($sp)
	addi $sp,$sp,8
	jr $ra
	
imprimir:
	
	
	li $s0,0	# i = 0
	move $t2,$a0
	move $t3,$a1
	for:
	bge $s0,$t3,exit	# si i >= size, salte del for
	sll $t0,$s0,2
	add $t0,$t0,$t2
	lw $t1,0($t0)
	
	li $v0,1
	move $a0,$t1
	syscall
	
	
	
	addi $s0,$s0,1
	
	j for
	exit:
	move $a0,$t2
	move $a1,$t3
	jr $ra
	