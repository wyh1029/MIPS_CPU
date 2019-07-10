.data 
array: .space 4
run:.asciiz "1"
ping:.asciiz "0"

.text 
    addi $t1,$zero,400
    addi $t2,$zero,100
    addi $t3,$zero,4
    
    li $v0,5
    syscall
    move $t0,$v0
    
    div $t0, $t1 
    mfhi $t7
    beq $t7,$zero,if
    
    div $t0,$t2
    mfhi $t7
    beq $t7,$zero,else
    
    div $t0,$t3
    mfhi $t7
    bne $t7,$zero,else
    
if:
    li $v0,1
    la $a0,1
    syscall 
    j end
else:
    li $v0,1
    la $a0,0
    syscall
end:


