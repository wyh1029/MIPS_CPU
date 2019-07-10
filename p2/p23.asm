.data
zimu:.word 0:20
.text
li $v0, 5
syscall
move $s0, $v0 #s0是回文长度
sll $s7, $s0, 2 #s7是地址长度
move $s1, $0 #s1是地址
input:
li $v0, 12
syscall
sw $v0, zimu($s1)
addi $s1, $s1, 4
bne $s1, $s7, input

addi $s2, $s1, -4 #s2后序
move $s1, $0  #s1前序
judge:
lw $t0, zimu($s1) #t0 前值
lw $t1, zimu($s2) #t1 后值
bne $t0, $t1, no
sub $s3, $s2, $s1 #s3 差
blez $s3, yes #算完了
addi $s1, $s1, 4
addi $s2, $s2, -4
j judge


yes:
addi $a0, $0, 1
li $v0, 1
syscall
j exit

no:
addi $a0, $0, 0
li $v0, 1
syscall
j exit

exit:
li $v0, 10
syscall




