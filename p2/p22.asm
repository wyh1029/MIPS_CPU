.data
number: .word 0:100
space: .asciiz " "
.text
li $v0, 5
syscall
move $s0, $v0 #s0�Ǹ���
sll $s7, $s0, 2 #s7�ǵ�ַ��
move $s1, $0 #s1�ǵڼ���
input:
li $v0, 5
syscall
sw $v0, number($s2)
addi $s1, $s1, 1
sll $s2, $s1, 2 #s2�����ֵ�ַ
bne $s1, $s0, input
#####################################
move $s1, $0 #s1�ǵڼ�����

for1:
move $s2, $s1 #ÿ�����ĵڼ��αȽ�
move $t5, $s1

lw $t0, number($s2) #���Ƚ���
for2:

lw $t1, number($s2) #�Ƚ���
ble $t0, $t1, continue
move $t5, $s2 #t5 ��Сֵ��λ��
move $t0, $t1
continue:
addi $s2, $s2, 4
bne $s2, $s7, for2
lw $t6, number($s1) #t6��Ҫ��t��ֵ
sw $t0, number($s1) #t0����Сֵ
sw $t6, number($t5) #�൱�ڻ��ط�
addi $s1, $s1, 4
bne $s1, $s7, for1
####################################
move $s1, $0 #s1�����ַ
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



