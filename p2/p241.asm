.data
symbol: .word 0:8
array: .word 0:8
space: .asciiz " "
enter: .asciiz "\n"
.text
addi $t9, $0, 1 #t9永远等于1
li $v0, 5
syscall
move $s0, $v0 #s0是n


addi $a3, $0, 0#a3 index


fullarray:
    slt $t8, $a3, $s0 #t8 小于置1
    bne $t8, $0, for_21
    addi $t0, $0, 0 #t0是i
for_1_begin:
    sll $t1, $t0, 2 #t1=t0*4
    lw $a0, array($t1)
    li $v0, 1
    syscall
    la $a0, space
    li $v0, 4
    syscall
    addi $t0, $t0, 1
    bne $t0, $a3, for_1_begin
    la $a0, enter
    syscall
    
    jr $ra
for_21:
    addi $t0, $0, 0 #t0 i
for_22:
    slt $t6,$t0,$s0
    beq $t6, $0, next_3
    sll $t1, $t0, 2 #t1=t0*4
    sll $s1, $a3, 2 #s1=a3*4
    lw  $t2, symbol($t1) #symbol[t0]=t2
    bne $t2, 0, next_2
    #####
    addi $t3, $t0, 1
    sw $t3, array($s1) #array[a3]=t3
    sw $t9, symbol($t1) 
    
    
    sw $t0, 0($sp)
    subi $sp, $sp, 4
    sw $a3, 0($sp)
    subi $sp, $sp, 4    
    sw $ra, 0($sp)
    subi $sp, $sp, 4
    addi $a3, $a3, 1
    jal fullarray
    addi $sp, $sp, 4
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    lw $a3, 0($sp)
    addi $sp, $sp, 4
    lw $t0, 0($sp)

next_1:
    sll $t1, $t0, 2
    sw $0, symbol($t1)        



next_2:
    addi $t0, $t0, 1
   # bne $s0, $t0, for_22
    j for_22
next_3:
    jr $ra





