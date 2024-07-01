lb x10, 0(x0)
sb x10, 1030(x0)#carrega temperatura

addi x7, x0, 3 #desligando todos leds
sw x7, 1033(x0) 
addi x7, x0, 5
sw x7, 1033(x0) 
addi x7, x0, 6
sw x7, 1033(x0) 
addi x7, x0, 9
sw x7, 1033(x0) 
addi x7, x0, 10
sw x7, 1033(x0)
addi x7, x0, 11
sw x7, 1033(x0)  


loop:
    
    lh x10, 1031(x0)  # Lê o valor do sensor de temperatura e coloca em x10
	 
    # Checagem da faixa de temperatura e acendimento do LED
    addi x8, x0, 320
    blt x10, x8, amarelo_esq    # Se x10 <= 15, vá para amarelo_esq	

    addi x20, x0, 420
    blt x10, x20, verde_esq      # Se x10 <= 20, vá para verde_esq

    addi x21, x0, 530
    blt x10, x21, verde_dir      # Se x10 <= 25, vá para verde_dir

    addi x22, x0, 630
    blt x10, x22, amarelo_dir    # Se x10 <= 30, vá para amarelo_dir

    addi x23, x0, 730
    blt x10, x23, ver_dir   # Se x10 <= 35, vá para vermelho_dir

    # a temperatura maior que 35
    jal x0, ver_esq


	
amarelo_esq:
addi x7, x0, 3 #desligando todos leds
sw x7, 1033(x0) 
addi x7, x0, 5
sw x7, 1033(x0)  
addi x7, x0, 9
sw x7, 1033(x0) 
addi x7, x0, 10
sw x7, 1033(x0)
addi x7, x0, 11
sw x7, 1033(x0)
    
    addi x6, x0, 6
	addi x7, x0, 0xFF
	sw x6, 1033(x0)  
    sw x7, 1034(x0) # Acende o LED amarelo esquerdo (pino 6)
    jal x0, loop

verde_esq:
addi x7, x0, 3 #desligando todos leds
sw x7, 1033(x0) 
addi x7, x0, 5
sw x7, 1033(x0) 
addi x7, x0, 6
sw x7, 1033(x0) 
addi x7, x0, 9
sw x7, 1033(x0) 
addi x7, x0, 11
sw x7, 1033(x0)

    addi x6, x0, 10
    addi x28, x0, 0xFF
    sw x6, 1033(x0)
    sw x28, 1034(x0)             # Acende o LED verde esquerdo (pino 10)
    jal x0, loop

verde_dir:
addi x7, x0, 3 #desligando todos leds
sw x7, 1033(x0) 
addi x7, x0, 5
sw x7, 1033(x0) 
addi x7, x0, 6
sw x7, 1033(x0) 
addi x7, x0, 9
sw x7, 1033(x0) 
addi x7, x0, 10
sw x7, 1033(x0)

    addi x6, x0, 11
    addi x29, x0, 0xFF
    sw x6, 1033(x0)
    sw x29, 1034(x0)             # Acende o LED verde direito (pino 11)
    jal x0, loop

amarelo_dir:
addi x7, x0, 3 #desligando todos leds
sw x7, 1033(x0) 
addi x7, x0, 5
sw x7, 1033(x0) 
addi x7, x0, 6
sw x7, 1033(x0) 
addi x7, x0, 10
sw x7, 1033(x0)
addi x7, x0, 11
sw x7, 1033(x0)

    addi x6, x0, 9
    addi x30, x0, 0xFF
    sw x6, 1033(x0)
    sw x30, 1034(x0)             # Acende o LED amarelo direito (pino 9)
    jal x0, loop

ver_dir:
addi x7, x0, 3 #desligando todos leds
sw x7, 1033(x0) 
addi x7, x0, 6
sw x7, 1033(x0) 
addi x7, x0, 9
sw x7, 1033(x0) 
addi x7, x0, 10
sw x7, 1033(x0)
addi x7, x0, 11
sw x7, 1033(x0)

    addi x6, x0, 5
    addi x31, x0, 0xFF
    sw x6, 1033(x0)
    sw x31, 1034(x0)             # Acende o LED vermelho direito (pino 5)
    jal x0, loop

ver_esq: 
addi x7, x0, 5
sw x7, 1033(x0) 
addi x7, x0, 6
sw x7, 1033(x0) 
addi x7, x0, 9
sw x7, 1033(x0) 
addi x7, x0, 10
sw x7, 1033(x0)
addi x7, x0, 11
sw x7, 1033(x0)

    addi x6, x0, 3
    addi x5, x0, 0xFF
    sw x6, 1033(x0)
    sw x5, 1034(x0)            # Acende o LED vermelho esquerdo (pino 3)
    jal x0, loop

