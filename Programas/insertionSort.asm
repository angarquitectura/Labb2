.data
	v:.word 2,1,5,3,9
	size:.word 5
.text

	la $a0,v
	lw $a1,size
	
	jal insertionSort
	jal imprimir
	
	li $v0,10
	syscall
	




insertionSort:

	li $s0,0	# i = 0
for1:
	bge $s0,$a1,Exit1	# si i >= size, sal del ciclo
	move $t0,$s0		# j = i
	
while:
	blez $t0,Exit2		# si j <= 0, sal del while
	addi $t1,$t0,-1		# tem = j -1
	
	sll $t1,$t1,2
	add $t1,$t1,$a0
	lw $t2,0($t1)		# temp 1 = v[j-1]
	lw $t3,4($t1)		# temp 2 = v[j]
	
	ble $t2,$t3,Exit2
	sw $t2,4($t1)
	sw $t3,0($t1)
	j while
	# fin del ciclo
Exit2:
	addi $s0,$s0,1		# i++
	j for1
Exit1:
	jr $ra
	
imprimir:
	add $sp,$sp,-4
	sw $a0,0($sp)
	
	li $t0,0
for3:
	bge $t0,$a1,exitFor3
	
	sll $t1,$t0,2
	add $t1,$t1,$a0
	
	li $v0,1
	lw $a0,0($t1)
	syscall
	
	lw $a0,0($sp)
	
	addi $t0,$t0,1
	j for3
exitFor3:
	lw $a0,0($sp)
	addi $sp,$sp,4
	jr $ra
	

	
	
	
	
	
	
	
	
	
	
	
	
