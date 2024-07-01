addi x18, x0, 0
addi x6, x0, 0                  # counter
addi x7, x0, 4

input_loop:
	lw x29, 1025(x0)            # recebe um ascii da entrada
    beq x29, x0, input_loop     # verifica se não é nulo, se for reinicia o loop

	addi x29, x29, -48          # transforma para o numero real

    addi x6, x6, 1              # incrementa o contador
    slli x18, x18, 1            # x18 << 1
    beq x29, x0, next           # volta se o input foi 0
    addi x18, x18, 1            # adiciona 1
    next:
    blt x6, x7, input_loop      # volta para o input se o contador for menor que 4

addi x19, x0, 0                 # se encontrou o valor dado no input
addi x20, x0, 0                 # decoder final

slti x19, x18, 1                # x19 = valor da entrada < 1
addi x20, x0, b0111111    #0
blt x0, x19, print              # jump para o final

slti x19, x18, 2
addi x20, x0, b0000110    #1
blt x0, x19, print

slti x19, x18, 3
addi x20, x0, b1011011    #2
blt x0, x19, print

slti x19, x18, 4
addi x20, x0, b1001111    #3
blt x0, x19, print

slti x19, x18, 5
addi x20, x0, b1100110    #4
blt x0, x19, print

slti x19, x18, 6
addi x20, x0, b1101101    #5
blt x0, x19, print

slti x19, x18, 7
addi x20, x0, b1111101    #6
blt x0, x19, print

slti x19, x18, 8
addi x20, x0, b0000111    #7
blt x0, x19, print

slti x19, x18, 9
addi x20, x0, b1111111    #8
blt x0, x19, print

slti x19, x18, 10
addi x20, x0, b1101111    #9
blt x0, x19, print

slti x19, x18, 15
blt x0, x19, final              # apenas ignora se nenhum input valido foi dado

addi x20, x0, 0                 # seta para limpar se o input foi 1111

print:
andi x7, x20, b1000000          # salva o bit do segmento g
srai x10, x7, 6                 # posiciona o bit corretamente

andi x11, x20, b0111111         # salva os bits dos segmentos a-f 

sb x10, 1027(x0)                # carrega o bit do segmento g
sb x11, 1029(x0)                # carrega os bits dos segmentos a-f

final:
halt