.eqv STRING 4

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

li a7,12   # capta o char
ecall

li a7, 11  # printa o char
ecall

la t0, nome    # endereço inicial
addi t2, t0, 8 # endereço final

loop:
	bge t0, t2, perde
	lb t1, 0(t0)
	beq t1, a0, fora_loop
	
	addi t0, t0, 1
	j loop
perde: print_str("smt")
fora_loop: