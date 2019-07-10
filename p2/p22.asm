.data
number: .word 0:100
space: .asciiz " "
.text
li $v0, 5
syscall
move $s0, $v0 #s0是个数
sll $s7, $s0, 2 #s7是地址数
move $s1, $0 #s1是第几个
input:
li $v0, 5
syscall
sw $v0, number($s2)
addi $s1, $s1, 1
sll $s2, $s1, 2 #s2是数字地址
bne $s1, $s0, input
#####################################
move $s1, $0 #s1是第几个数

for1:
move $s2, $s1 #每个数的第几次比较
move $t5, $s1

lw $t0, number($s2) #被比较数
for2:

lw $t1, number($s2) #比较数
ble $t0, $t1, continue
move $t5, $s2 #t5 最小值的位置
move $t0, $t1
continue:
addi $s2, $s2, 4
bne $s2, $s7, for2
lw $t6, number($s1) #t6存要被t的值
sw $t0, number($s1) #t0存最小值
sw $t6, number($t5) #相当于换地方
addi $s1, $s1, 4
bne $s1, $s7, for1
####################################
move $s1, $0 #s1输出地址
sll $s0, $s0, 2
output:
lw $a0, number($s1)
li $v0, 1
syscall
la $a0, space
li $v0, 4
syscall
addi $s1, $s1, 4
bne $s1, $s0, output
li $v0, 10
syscall



