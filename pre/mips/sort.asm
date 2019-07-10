.data
  array: .space 400
  message_input_n: .asciiz "please input n:\n"
  message_input_array: .asciiz "please input array:\n"
  message_output_array: .asciiz " output array:\n"
  space: .asciiz " "
  stack: .space 100
.text 
input:
  la $a0, message_input_n
  li $v0, 4
  syscall 
  
  li $v0, 5
  syscall 
  move $t0,$v0
  
  li $t1,0
for_1_begin:
    slt $t2, $t1, $t0
    beq $t2,$zero,for_1_end
    nop
    
    la $t2, array
    li $t3, 4
    mult $t3, $t1
    mflo $t3
    addu $t2,$t2,$t3
    
    la $a0, message_input_array
    li $v0,4
    syscall 
    
    li $v0,5
    syscall   
      
    sw $v0,0($t2)
          
    addi $t1,$t1,1
    j for_1_begin
    nop
for_1_end:          
    move $v0,$t0
    jr $ra
    nop
    
output:
    move $t0,$a0
    
  
  
  
  


