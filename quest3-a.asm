lw x12, num1    # copia x12 em x28 (a)
lw x13, num2    # copia x13 em x5  (b)

addi x18, x0, 45        # hifen ascii
addi x19, x0, 48        # nums init ascii

jal x1, mult            # chama a função de multiplicação

addi x20, x10, 0        # salva o resultado

jal x0, end_code        # finaliza o código

# --------------- finish code ---------------

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

    jalr x0, 0(x1)              # retorna

end_code:

halt
num1: .word 0x1869F
num2: .word -0x1869F