.data
 	frase1:.asciiz "Digite um número de 9 digitos para gerar um CPF :\n"               
 	frase2:.asciiz "O CPF gerado é : \n"
 	digitos:.asciiz ""
 	espaco:.asciiz "       "
 	ver1:.word 0
 	ver2:.word 0
.text
.globl main
main:
	li $v0, 4
	la $a0, frase1  # imprime a frase1
	syscall
	li $v0, 8
	la $a0, digitos # faz a leitura dos digitos
	li $a1, 100
	syscall

	li $t0, 0	#indice
	li $t1, 10 # codigo que indica o fim de uma frase
	li $t3, 0
	li $t5, 0 #somador
	li $t6, 10 #multiplicador
	WHILE: 
		lb $t2, digitos($t0) # captura uma letra
		li $t4, 48
		bne $t2, $t4, um
		li $t7, 0
		add $s7, $s7, $t7
		mul $t7, $t7, $t6
		add $t5, $t5, $t7
		j FIM_SELECAO
	um:
		li $t4, 49
		bne $t2, $t4, dois
		li $t7, 1
		add $s7, $s7, $t7
		mul $t7, $t7, $t6
		add $t5, $t5, $t7 
		j FIM_SELECAO
	dois:
		li $t4, 50
		bne $t2, $t4, tres
		li $t7, 2
		add $s7, $s7, $t7
		mul $t7, $t7, $t6
		add $t5, $t5, $t7
		j FIM_SELECAO
	tres:
		li $t4, 51
		bne $t2, $t4, quatro
		li $t7, 3
		add $s7, $s7, $t7
		mul $t7, $t7, $t6
		add $t5, $t5, $t7
		j FIM_SELECAO
	quatro:
		li $t4, 52
		bne $t2, $t4, cinco
		li $t7, 4
		add $s7, $s7, $t7
		mul $t7, $t7, $t6
		add $t5, $t5, $t7
		j FIM_SELECAO
	cinco:
		li $t4, 53
		bne $t2, $t4, seis
		li $t7, 5
		add $s7, $s7, $t7
		mul $t7, $t7, $t6
		add $t5, $t5, $t7
		j FIM_SELECAO
	seis:
		li $t4, 54
		bne $t2, $t4, sete
		li $t7, 6
		add $s7, $s7, $t7
		mul $t7, $t7, $t6
		add $t5, $t5, $t7
		j FIM_SELECAO
	sete:
		li $t4, 55
		bne $t2, $t4, oito
		li $t7, 7
		add $s7, $s7, $t7
		mul $t7, $t7, $t6
		add $t5, $t5, $t7
		j FIM_SELECAO
	oito:
		li $t4, 56
		bne $t2, $t4, nove
		li $t7, 8
		add $s7, $s7, $t7
		mul $t7, $t7, $t6
		add $t5, $t5, $t7
		j FIM_SELECAO
	nove:
		li $t4, 57
		bne $t2, $t4, FIM_SELECAO
		li $t7, 9
		add $s7, $s7, $t7
		mul $t7, $t7, $t6
		add $t5, $t5, $t7
	FIM_SELECAO:
		beq $t2, $t1, MOD # verifica se todos os numeros ja foram lidos
		addi $t0, $t0, 1 # aumenta o indice
		addi $t6, $t6, -1	# diminui o multiplicador
		
		j WHILE
	MOD:
		addi $t3, $t3, 1
		li $s0, 11
		div $s1, $t5, $s0
		mul $s2, $s0, $s1
		sub $s3, $t5, $s2 
		li $s4, 1
		bne $s3, $s4, DEC
		addi $s3, $s3, -1 #se for 1 vira 0
		DEC:
		li $s4, 0
		beq $s3, $s4, ELSE
		sub $s3, $s0, $s3   #digito = 11 - resto
		
	ELSE:
		li $t7, 1
		bne $t3, $t7, V1
		sw $s3, ver1
		V1:
		sw $s3, ver2
		add $t5, $t5, $s7
		mul $s3, $s3, 2
		add $t5, $t5, $s3
		
		beq $t3, $t7, MOD
	FIM_WHILE:

		li $v0, 4
		la $a0, frase2
		syscall
		
		la $a0, espaco
		
		li $v0, 4
		la $a0, digitos
		syscall
		
		li $v0, 1
		lw $t0, ver1
		addi $a0, $t0, 0
		syscall
	
		li $v0, 1
		lw $t0, ver2
		addi $a0, $t0, 0
		syscall
		
Fim:
