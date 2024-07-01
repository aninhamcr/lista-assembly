addi x2, x0, 0x7f0

loop:
	lb x10, 1025(x0) # input do caracter
	beq x10, x0, aqui
	addi x10, x10, -48
	addi x20, x0, 0 # zero para comparações
    addi x22, x0, 0 # contador auxiliar
	jal x0, fat
	volta: 
	add x23, x23, x9 
	addi x9, x0, 0 #zera tudo
	addi x8, x0, 0
	addi x10, x0, 0
	addi x22, x0, 0
	jal x11, loop

fat:
    addi x18, x0, 0 #soma
	addi x19, x0, 0	#contador
	jal x0, mult
	continua:
	bne x10, x20, fat #se for diferente de 0 continua

mult: 
    bne x22, x20, pulo
	addi x9, x10, 0 #copio n pro x9
    pulo:
	addi x8, x10, -1 #copio n-1 pro x8
	beq x8, x20, fim #se for "vezes 0" nao faz a multiplicação
	smloop:
		add x18, x18, x9 #eh tipo um 4 + 4 + 4 tlg
		addi x19, x19, 1 #incrementa contador
		blt x19, x8, smloop
    addi x9, x18, 0 #copia resultado da multiplicação pro x9 
    addi x22, x22, 1
	add x10, x8, x0
	jal x0, continua

fim:
	jal x0, volta

aqui:
	addi x12, x23, 0
	jal x1, bin_to_bcd 

slti x21, x23, 0        # utilizado para salvar o sinal do numero
beq x21, x0, m_positivo
sub x23, x0, x23
m_positivo:

addi x12, x20, 0
jal x1, bin_to_bcd
addi x22, x10, 0        # salva o endereço (mem) resultante

beq x21, x0, n_print_negativo
sb x18, 1024(x0)
n_print_negativo:

addi x5, x10, 0
addi x7, x10, 10        # bytes read limit

find_first:
    lb x6, 0(x5)
    addi x5, x5, 1
    bge x5, x7, print_all
    beq x6, x0, find_first
end_find_first:

bge x7, x5, print_all
print_zero:
    sb x19, 1024(x0)
    jal x0, end_code

print_all:
    addi x28, x6, 48   # number ascii
    sb x28, 1024(x0)
    lb x6, 0(x5)
    addi x5, x5, 1
    bge x7, x5, print_all

	jal x0, end_code


bin_to_bcd:
    addi x2, x2, -10

    addi x5, x0, 0      # counter
    addi x6, x23, 0     # copy of x12
    addi x7, x0, 0      # number for subtraction

    addi x5, x0, -1
    lui x7, 0xC4653  #
    xori x7, x7, 0xA00  # 10 ^ 10
    _bcd1:
        addi x5, x5, 1
        sub x6, x6, x7
        bge x6, x0, _bcd1
    add x6, x6, x7
    sb x5, 0(x2)

    addi x5, x0, -1
    lui x7, 0x5F5E  #
    ori x7, x7, 0x100  # 10 ^ 9
    _bcd2:
        addi x5, x5, 1
        sub x6, x6, x7
        bge x6, x0, _bcd2
    add x6, x6, x7
    sb x5, 1(x2)

    addi x5, x0, -1
    lui x7, 0x989  #
    ori x7, x7, 0x680  # 10 ^ 8
    _bcd3:
        addi x5, x5, 1
        sub x6, x6, x7
        bge x6, x0, _bcd3
    add x6, x6, x7
    sb x5, 2(x2)

    addi x5, x0, -1
    lui x7, 0xF4  #
    ori x7, x7, 0x240  # 10 ^ 7
    _bcd4:
        addi x5, x5, 1
        sub x6, x6, x7
        bge x6, x0, _bcd4
    add x6, x6, x7
    sb x5, 3(x2)

    addi x5, x0, -1
    lui x7, 0x18  #
    ori x7, x7, 0x6A0  # 10 ^ 6
    _bcd5:
        addi x5, x5, 1
        sub x6, x6, x7
        bge x6, x0, _bcd5
    add x6, x6, x7
    sb x5, 4(x2)

    addi x5, x0, -1
    lui x7, 0x2  #
    ori x7, x7, 0x710  # 10 ^ 5
    _bcd6:
        addi x5, x5, 1
        sub x6, x6, x7
        bge x6, x0, _bcd6
    add x6, x6, x7
    sb x5, 5(x2)

    addi x5, x0, -1
    addi x7, x0, 0
    ori x7, x7, 0x3E8  # 10 ^ 4
    _bcd7:
        addi x5, x5, 1
        sub x6, x6, x7
        bge x6, x0, _bcd7
    add x6, x6, x7
    sb x5, 6(x2)

    addi x5, x0, -1
    addi x7, x0, 0
    ori x7, x7, 0x64  # 10 ^ 3
    _bcd8:
        addi x5, x5, 1
        sub x6, x6, x7
        bge x6, x0, _bcd8
    add x6, x6, x7
    sb x5, 7(x2)

    addi x5, x0, -1
    addi x7, x0, 0
    ori x7, x7, 0xA  # 10 ^ 2
    _bcd9:
        addi x5, x5, 1
        sub x6, x6, x7
        bge x6, x0, _bcd9
    add x6, x6, x7
    sb x5, 8(x2)

    addi x5, x0, -1
    addi x7, x0, 0
    ori x7, x7, 0x1  # 10 ^ 1
    _bcd10:
        addi x5, x5, 1
        sub x6, x6, x7
        bge x6, x0, _bcd10
    add x6, x6, x7
    sb x5, 9(x2)

    addi x10, x2, 0
    jalr x0, 0(x1)


end_code:
	halt
