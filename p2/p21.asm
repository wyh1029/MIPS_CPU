.data

data1: .word 0:64
data2: .word 0:64
result:.word 0:64
space: .asciiz " "
enter: .asciiz "\n"
.text 
input:
li $v0, 5
syscall
move $t0, $v0 #t0 行数
move $t1, $v0 #t1 列数
move $s7, $v0 #s7 行数，列数

move $s0, $zero #s0 当前行
move $s1, $zero #s1 当前列
move $s2, $zero #s2 当前数
loop1: #第一个矩阵输入
mult $s0, $t1 
mflo $s2 #第几行数
add $s2, $s2, $s1 #第几列数，即所存数的位置
sll $s2, $s2, 2 #*4
li $v0, 5
syscall
move $t2, $v0 #t2 输入的值
sw $t2, data1($s2)
addi $s1, $s1, 1 #列加一
bne $s1, $t1, loop1
move $s1, $zero #换行
addi $s0, $s0, 1 
bne $s0, $t0, loop1 #结束

move $s0, $zero
move $s1, $zero
move $s2, $zero
loop2: #第二个矩阵输入
mult $s0, $t1
mflo $s2
add $s2, $s2, $s1
sll $s2, $s2, 2
li $v0, 5
syscall
move $t2, $v0
sw $t2, data2($s2)
addi $s1, $s1, 1
bne $s1, $t1, loop2
move $s1, $zero
addi $s0, $s0, 1
bne $s0, $t0, loop2

move $t0, $0 
move $t4, $0
move $s0, $0
move $s1, $0
move $s2, $0
move $s3, $0
move $s4, $0
sll $t5, $s7, 2
cct_w:
mult $s0, $t5 
mflo $s3
sll $s4, $s1, 2
move $t4, $0
cct_n:#计算
#t0 每个数的n次加法计数
#t1 第一个数 t2 第二个数
#t3 每次乘法的结果
#t4 最终结果
#t5 列加
#s1 列数计数
#s0 行数计数
#s2 结果地址
#s3 第一个数地址 
#s4 第二个数地址
#s7 行数，列数总数
lw $t1, data1($s3)
lw $t2, data2($s4)
mult $t1, $t2
mflo $t3
add $t4, $t4, $t3
addi $t0, $t0, 1
addi $s3, $s3, 4
add $s4, $s4, $t5  
bne $t0, $s7, cct_n
move $t0, $0
sw $t4, result($s2)# t4最终结果存进result
addi $s2, $s2, 4
addi $s1, $s1, 1
bne $s1, $s7, cct_w
move $s1, $zero
addi $s0, $s0, 1
bne $s0, $s7, cct_w

move $s0, $0
move $s1, $0 
move $t7, $t5
output:
lw $a0, result($s0)
li $v0, 1
syscall
la $a0, space
li $v0, 4
syscall
addi $s0, $s0, 4
bne $s0, $t5, output
add $t5, $t5, $t7
la $a0, enter
li $v0, 4
syscall
addi $s1, $s1, 1
bne $s1, $s7, output
li $v0, 10
syscall
    
    
    
    
