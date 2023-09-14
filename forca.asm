.eqv STRING 4
.eqv COMPRIMENTO_NOME 7

.macro print_str (%str)
.data
text: .string %str
.text
	li a7, STRING # print str cmd
	la a0, text
	ecall
.end_macro

.data
nome: .string "ronaooo"
nome_secreto: .string "_ _ _ _ _ _ _"
espaço : .string 
.text

print_str("VIDAS ")
li s0, 6  # VIDAS do usario
mv a0, s0
li a7, 1  # printa
ecall

print_str("\n    ")


la a0,nome_secreto # a0 = nome_secreto
li a7,4    # a7 = 1 # print integer cmd
ecall

print_str("\n")


game_loop:
print_str(" \n ")
la t5, nome_secreto
li t4, 0
li t3, -1
mv zero, t4
la t0, nome    # endereço inicial
addi t2, t0, COMPRIMENTO_NOME # endereço final
li a7,12   # capta o char
ecall
loop: #descobrir se tem o numero a0 = letra chute
	bge t0, t2, perde#se n tiver perde vida
	lb t1, 0(t0)
	beq t1, a0, venceu#se tiver salva no t4
	
	addi t0, t0, 1
	addi t4, t4, 1
	j loop
	segunda_verificacao:
	addi t0, t0, 1
	addi t4, t4, 1
	
	bge t0, t2, imprime_palavra#se n tiver perde vida
	lb t6, 0(t0)
	beq t1, t6, salva_letra#se tiver salva no t4
	j segunda_verificacao
	
perde: print_str(" \n smt ") #caso não tenha 
	addi s0 , s0 ,-1 # adicionar -1
	beq s0, zero,fora_loop # caso s0 = 0,fora loop
	mv a0,s0 # print
	li a7, 1 # print
	ecall
	
	j game_loop
venceu: 
	print_str("\n")
	# t0 = endereco da letra, t1= letra t2= enderoco final, 
	#Retirado --t3 = loop controle--, t4= pos da letra atual, t5 = end. nome pra revelar
	#print_str(" tem")
	salva_letra: 
	li a1, 2
	mul a1, a1, t4#dobro de pos
	add a0, a1, t5
	sb t1, 0(a0)
	j segunda_verificacao
	imprime_palavra:
	la a0, nome_secreto
	li a7, 4
	ecall
	j game_loop
	
fora_loop:
	print_str(" saiu do loop")
