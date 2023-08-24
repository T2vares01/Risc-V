.eqv STRING 4
.eqv COMPRIMENTO_NOME 8

.macro print_str (%str)
.data
text: .string %str
.text
	li a7, STRING # print str cmd
	la a0, text
	ecall
.end_macro

.data
nome: .string "ronaldo"
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

 #li a7,12   # capta o char
#ecall
game_loop:
la t0, nome    # endereço inicial
addi t2, t0, COMPRIMENTO_NOME # endereço final
li a7,12   # capta o char
ecall
loop:
	bge t0, t2, perde
	lb t1, 0(t0)
	beq t1, a0, venceu
	
	addi t0, t0, 1
	j loop
perde: print_str(" \n smt ") #caso não tenha 
	addi s0 , s0 ,-1 # adicionar -1
	beq s0, zero,fora_loop # caso s0 = 0,fora loop
	mv a0,s0 # print
	li a7, 1 # print
	ecall
	
	j game_loop
venceu: 
	print_str(" tem")
	mv a0, t1
	li a7,11
	ecall
	
fora_loop:
	print_str(" saiu do loop")
