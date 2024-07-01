addi x2, x0, 0x7f0          # stack  
jal x1, input               # recebe o primeiro número
addi x8, x10, 0             # salva o resultado

jal x1, input               # recebe o segundo número
addi x9, x10, 0             # salva o resultado

addi x18, x0, 45            # hifen ascii
addi x19, x0, 48            # nums init ascii

addi x12, x8, 0             # parametro "a" da mult
addi x13, x9, 0             # parametro "b" da mult
jal x1, mult                # chama a função de multiplicação
addi x20, x10, 0            # salva o resultado

# print do resultado
slti x21, x20, 0            # salva o sinal do numero
beq x21, x0, m_positivo
sub x20, x0, x20            # transforma o número em positivo
m_positivo:

addi x12, x20, 0            # passa o parametro para a função
jal x1, bin_to_bcd          # chama a função de conversão

beq x21, x0, n_print_negativo   # verifica se o número é negativo
sb x18, 1024(x0)            # printa o sinal negativo
n_print_negativo:

addi x5, x10, 0             # endereço para os valores em bcd
addi x7, x10, 10            # bytes read limit

# procura o primeiro número diferente de zero
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
    add x28, x6, x19   # number ascii
    sb x28, 1024(x0)
    lb x6, 0(x5)
    addi x5, x5, 1
    bge x7, x5, print_all

jal x0, end_code

# --------------- finish code ---------------

# entrada: número com sinal, no final dar um espaço ou enter.
# return: x10 (signed int)
# uses x18, x19, x20 and x29
input:
    addi x18, x0, 0	            # sinal = 0
    addi x19, x0, -3	        # ascii: hifen - 48
    addi x20, x0, 0             # num
    addi x29, x0, 0             # inp_tmp = 0

    addi x2, x2, -16            # decrementa o ponteiro da stack
    sw x18, 0(x2)               # salva o valor de x18 na stack
    sw x19, 4(x2)               # salva o valor de x19 na stack
    sw x20, 8(x2)               # salva o valor de x20 na stack
    sw x1, 12(x2)               # salva o valor de retorno

input_loop:
	lw x29, 1025(x0)            # recebe um ascii da entrada
    beq x29, x0, input_loop     # verifica se não é nulo, se for reinicia o loop

	addi x29, x29, -48          # transforma para o numero real
	blt x29, x0, negativo       # se o valor for negativo então não é um numero, pode ser o hifen ou espaço
	
    # Multiplica o valor anterior salvo de num por 10 e soma o inteiro 
    addi x12, x20, 0            # parametro a
    addi x13, x0, 10            # parametro b
    jal x1, mult                # chama a função de multiplicação

    add x20, x10, x29           # x7 = x7 * 10 + x29
	jal x0, input_loop          # retorna o input para verificar se irá receber outra entrada

	negativo:
        bne x29, x19, espaco    # verifica se o ascii recebido é o hifen, se não for, pular para o espaco
        addi x18, x0, 1         # seta a flag de número negativo

	    jal x0, input_loop      # reinicia o loop -> o número só é transformado em negativo após o ultimo dígito
    
    # quando recebe um espaço ou enter significa que o número foi finalizado
    espaco:                     
        beq x0, x18, positivo   # verifica se a flag de sinal está ativa
            sub x20, x0, x20    # faz o complemento a dois do número
        positivo:
        
        add x10, x0, x20        # move os número obtido para o registrador de retorno
        lw x18, 0(x2)           # recupera o valor de x18
        lw x19, 4(x2)           # recupera o valor de x19
        lw x20, 8(x2)           # recupera o valor de x20
        lw x1, 12(x2)           # recupera o ponteiro de retorno
        addi x2, x2, 16         # incrementa o ponteiro da stack
        jalr x0, 0(x1)          # retorna 
        #jal x0, end_code

# args: x12 (signed int), x13 (signed int) ||| return: x10 (signed int)
# uses x5, x6, x7 and x28
mult:           
    addi x10, x0, 0

    add x28, x0, x12    # copia x12 em x28 (a)
    add x5, x0, x13     # copia x13 em x5  (b)

    addi x6, x0, 0          # zera x6 (flag de negativo)
    bge x5, x0, loop_mult   # se x5 é positivo vai para o loop_mult
    addi x6, x0, 1          # x6 = 1 (flag de negativo)
    sub x5, x0, x5          # transforma x5 em positivo

    loop_mult:
        andi x7, x5, 1          # x7 é ultimo bit de x5
        bge x0, x7, non_sum     # se x7 é 0 vai para non_sum
        add x10, x10, x28       # x10 = x10 + x28
        non_sum:
        srli x5, x5, 1          # x5 = x5 >> 1
        slli x28, x28, 1        # x28 = x28 << 1
        blt x0, x5, loop_mult   # se x5 > 0 vai para loop_mult

    end:

    beq x0, x6, nao_negativo    # se x6 > 0 vai para nao_negativo
    sub x10, x0, x10            # x10 = -x10
    nao_negativo:

    jalr x0, 0(x1)


# args: x12 (unsigned number to convert to BCD) | return: x10 (pointer to BCD result)
# uses x5, x6 and x7
bin_to_bcd:
    addi x2, x2, -10

    addi x5, x0, 0      # counter
    addi x6, x12, 0     # copy of x12
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