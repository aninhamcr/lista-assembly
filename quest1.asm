# Inicializa x20 e x19 com 0
addi x20, x0, 0       # Inicializa x20 com 0
addi x19, x0, 0       # Inicializa x19 com 0

# 1 = jogador 1 ganhou, 2 = jogador 2 ganhou, 3 = empate

input_loop:

    lb x29, 1025(x0)   # Recebe um caractere ASCII de entrada

    addi x22, x0, 32    # Checa se é espaço (ASCII 32)
    beq x29, x22, input_segundo_loop    # Verifica se não é nulo, se for vai pro segund loop ler a segunda palavra 

    # Checa se a letra é 'D', 'G' ou 'T'
    addi x22, x0, 68
    beq x29, x22, grupo_UM_1  # 'D' em ASCII é 68

    addi x22, x0, 71
    beq x29, x22, grupo_UM_1 # 'G' em ASCII é 71

    addi x22, x0, 84
    beq x29, x22, grupo_UM_1 # 'T' em ASCII é 84

    # Checa se a letra é 'F', 'H', 'V', 'W' ou 'Y'
    addi x22, x0, 70
    beq x29, x22, grupo_DOIS_1  # 'F' em ASCII é 70
    addi x22, x0, 72
    beq x29, x22, grupo_DOIS_1  # 'H' em ASCII é 72
    addi x22, x0, 86
    beq x29, x22, grupo_DOIS_1  # 'V' em ASCII é 86
    addi x22, x0, 87
    beq x29, x22, grupo_DOIS_1  # 'W' em ASCII é 87
    addi x22, x0, 89
    beq x29, x22, grupo_DOIS_1  # 'Y' em ASCII é 89

    # Checa se a letra é 'A', 'E', 'I', 'O' ou 'U'
    addi x22, x0, 65
    beq x29, x22, grupo_TRES_1  # 'A' em ASCII é 65
    addi x22, x0, 69
    beq x29, x22, grupo_TRES_1  # 'E' em ASCII é 69
    addi x22, x0, 73
    beq x29, x22, grupo_TRES_1  # 'I' em ASCII é 73
    addi x22, x0, 79
    beq x29, x22, grupo_TRES_1  # 'O' em ASCII é 79
    addi x22, x0, 85
    beq x29, x22, grupo_TRES_1  # 'U' em ASCII é 85

    # Checa se a letra é 'B', 'C', 'M', 'N' ou 'P'
    addi x22, x0, 66
    beq x29, x22, grupo_QUATRO_1  # 'B' em ASCII é 66
    addi x22, x0, 67
    beq x29, x22, grupo_QUATRO_1  # 'C' em ASCII é 67
    addi x22, x0, 77
    beq x29, x22, grupo_QUATRO_1  # 'M' em ASCII é 77
    addi x22, x0, 78
    beq x29, x22, grupo_QUATRO_1  # 'N' em ASCII é 78
    addi x22, x0, 80
    beq x29, x22, grupo_QUATRO_1  # 'P' em ASCII é 80

    # Checa se a letra é 'K', 'R' ou 'S'
    addi x22, x0, 75
    beq x29, x22, grupo_CINCO_1  # 'K' em ASCII é 75
    addi x22, x0, 82
    beq x29, x22, grupo_CINCO_1  # 'R' em ASCII é 82
    addi x22, x0, 83
    beq x29, x22, grupo_CINCO_1  # 'S' em ASCII é 83

    # Checa se a letra é 'Q' ou 'Z'
    addi x22, x0, 81
    beq x29, x22, grupo_SEIS_1  # 'Q' em ASCII é 81
    addi x22, x0, 90
    beq x29, x22, grupo_SEIS_1  # 'Z' em ASCII é 90

    # Checa se a letra é 'J', 'L' ou 'X'
    addi x22, x0, 74
    beq x29, x22, grupo_OITO_1  # 'J' em ASCII é 74
    addi x22, x0, 76
    beq x29, x22, grupo_OITO_1  # 'L' em ASCII é 76
    addi x22, x0, 88
    beq x29, x22, grupo_OITO_1  # 'X' em ASCII é 88

    jal x0, input_loop  # Se não for nenhuma das letras acima, volta pro loop

grupo_UM_1:
    addi x20, x20, 1
    jal x0, input_loop
grupo_DOIS_1: 
    addi x20, x20, 2
    jal x0, input_loop
grupo_TRES_1:
    addi x20, x20, 3
    jal x0, input_loop
grupo_QUATRO_1: 
    addi x20, x20, 4
    jal x0, input_loop
grupo_CINCO_1: 
    addi x20, x20, 5
    jal x0, input_loop
grupo_SEIS_1: 
    addi x20, x20, 6
    jal x0, input_loop
grupo_OITO_1: 
    addi x20, x20, 8
    jal x0, input_loop

input_segundo_loop:
    lb x29, 1025(x0)   # Recebe um caractere ASCII de entrada

    beq x29, x0, calcular  # Verifica se não é nulo, se for vai direto calcular a pontuacao

    # Checa se a letra é 'D', 'G' ou 'T'
    addi x22, x0, 68
    beq x29, x22, grupo_UM  # 'D' em ASCII é 68

    addi x22, x0, 71
    beq x29, x22, grupo_UM  # 'G' em ASCII é 71

    addi x22, x0, 84
    beq x29, x22, grupo_UM  # 'T' em ASCII é 84

    # Checa se a letra é 'F', 'H', 'V', 'W' ou 'Y'
    addi x22, x0, 70
    beq x29, x22, grupo_DOIS  # 'F' em ASCII é 70
    addi x22, x0, 72
    beq x29, x22, grupo_DOIS  # 'H' em ASCII é 72
    addi x22, x0, 86
    beq x29, x22, grupo_DOIS  # 'V' em ASCII é 86
    addi x22, x0, 87
    beq x29, x22, grupo_DOIS  # 'W' em ASCII é 87
    addi x22, x0, 89
    beq x29, x22, grupo_DOIS  # 'Y' em ASCII é 89

    # Checa se a letra é 'A', 'E', 'I', 'O' ou 'U'
    addi x22, x0, 65
    beq x29, x22, grupo_TRES  # 'A' em ASCII é 65
    addi x22, x0, 69
    beq x29, x22, grupo_TRES  # 'E' em ASCII é 69
    addi x22, x0, 73
    beq x29, x22, grupo_TRES  # 'I' em ASCII é 73
    addi x22, x0, 79
    beq x29, x22, grupo_TRES  # 'O' em ASCII é 79
    addi x22, x0, 85
    beq x29, x22, grupo_TRES  # 'U' em ASCII é 85

    # Checa se a letra é 'B', 'C', 'M', 'N' ou 'P'
    addi x22, x0, 66
    beq x29, x22, grupo_QUATRO  # 'B' em ASCII é 66
    addi x22, x0, 67
    beq x29, x22, grupo_QUATRO  # 'C' em ASCII é 67
    addi x22, x0, 77
    beq x29, x22, grupo_QUATRO  # 'M' em ASCII é 77
    addi x22, x0, 78
    beq x29, x22, grupo_QUATRO  # 'N' em ASCII é 78
    addi x22, x0, 80
    beq x29, x22, grupo_QUATRO  # 'P' em ASCII é 80

    # Checa se a letra é 'K', 'R' ou 'S'
    addi x22, x0, 75
    beq x29, x22, grupo_CINCO  # 'K' em ASCII é 75
    addi x22, x0, 82
    beq x29, x22, grupo_CINCO  # 'R' em ASCII é 82
    addi x22, x0, 83
    beq x29, x22, grupo_CINCO  # 'S' em ASCII é 83

    # Checa se a letra é 'Q' ou 'Z'
    addi x22, x0, 81
    beq x29, x22, grupo_SEIS  # 'Q' em ASCII é 81
    addi x22, x0, 90
    beq x29, x22, grupo_SEIS  # 'Z' em ASCII é 90

    # Checa se a letra é 'J', 'L' ou 'X'
    addi x22, x0, 74
    beq x29, x22, grupo_OITO  # 'J' em ASCII é 74
    addi x22, x0, 76
    beq x29, x22, grupo_OITO  # 'L' em ASCII é 76
    addi x22, x0, 88
    beq x29, x22, grupo_OITO  # 'X' em ASCII é 88

    jal x0, input_segundo_loop  # Se não for nenhuma das letras acima, volta pro loop

grupo_UM:
    addi x19, x19, 1
    jal x0, input_segundo_loop
grupo_DOIS: 
    addi x19, x19, 2
    jal x0, input_segundo_loop
grupo_TRES: 
    addi x19, x19, 3
    jal x0, input_segundo_loop
grupo_QUATRO: 
    addi x19, x19, 4
    jal x0, input_segundo_loop
grupo_CINCO: 
    addi x19, x19, 5
    jal x0, input_segundo_loop
grupo_SEIS: 
    addi x19, x19, 6
    jal x0, input_segundo_loop
grupo_OITO: 
    addi x19, x19, 8
    jal x0, input_segundo_loop

calcular:
   
    blt x19, x20, jogador_1_maior   # Se x20 > x19, jogador_1_maior
    blt x20, x19, jogador_2_maior   # Se x20 < x19, jogador_2_maior
    # Se for empate, pode adicionar um label para empate
    addi x19, x0, 51
    sb x19, 1024(x0)
    jal x0, done

jogador_1_maior:

        addi x20, x0, 49
		sb x20, 1024(x0)
        jal x0, done

jogador_2_maior:
        addi x19, x0, 50
		sb x19, 1024(x0)
       jal x0, done

done:

    halt