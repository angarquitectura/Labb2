.data
arr: .word 2,1,6,3,7,9,20,5
size: .word 8
space: .asciiz "\n"
sms: .asciiz "ordenando\n"
.text
main:
la $a0,arr
lw $a1,size
jal imprimir
la $a0,sms
li $v0,4
syscall
la $a0,arr
lw $a1,size
jal insertion
la $a0,arr
lw $a1,size
jal imprimir

li $v0,10
syscall
	insertion:
		li $s0,1 #i=1
		for1:
			bge $s0,$a1,exit1
			move $t0,$s0 #j=i
			while:
				blez $t0,exit2 
				addi $t1,$t0,-1 	# $t1=j-1  indice
				sll $t4,$t1,2 		#offset
				add $t4,$a0,$t4		#$t4=addres arr[j-1]
				lw $t2,0($t4)		#t2= arr[j-1]
				sll $t5,$t0,2		#offset de arr[j]
				add $t5,$a0,$t5		#$t5= addres arr[j]
				lw $t3,0($t5)		#$t3=arr[j]
				ble $t2,$t3,exit2
				sw $t3,0($t4) 		#arr[j-1]=arr[j]
				sw $t2,0($t5)		#arr[j]=arr[j-1]
				addi $t0,$t0,-1		#i--
			j while
			exit2:
		addi $s0,$s0,1
		j for1
		exit1:
		jr $ra
	imprimir:
	li $s0,0	# i = 0
	move $t2,$a0
	move $t3,$a1
	for11:
	bge $s0,$t3,exit	# si i >= size, salte del for
	sll $t0,$s0,2
	add $t0,$t0,$t2
	lw $t1,0($t0)
	
	li $v0,1
	move $a0,$t1
	syscall
	li $v0,4
	la $a0,space
	syscall
	addi $s0,$s0,1	
	j for11
	exit:
	move $a0,$t2
	move $a1,$t3
	jr $ra