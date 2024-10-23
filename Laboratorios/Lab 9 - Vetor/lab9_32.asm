TITLE Ler Vetor
.MODEL SMALL
.stack 0100h
.DATA

    MG1   DB 13,10,'Insira o valor da posicao do seu vetor:', '$'
    INSER DB 13,10,'O vetor inserido foi: ','$'
    RESP  DB 13,10,'E seu resultado invertido: ','$'
    L1    DW 7 DUP (0)

.CODE
MAIN PROC
    ;Acesso ao DATA
              MOV  AX, @DATA
              MOV  DS,AX

              CALL LER_VETOR    ;Leva até a subrotina "LER_VETOR" para inserir os caranteres do VETOR

    ;Exibe a mensagem INSER antes de da sub rotina IMPRIME para evitar a repetição da mesma funcionalinade
              LEA  DX, INSER
              MOV  AH, 09
              INT  21H
              CALL IMPRIME      ;Leva até a subrotina "IMPRIME" para impressão do VETOR, nesse caso, apenas exibindo o vetor inserido;

              CALL INVERTE      ;Leva até a subrotina "INVERTE" para impressão do VETOR
              
    ;Exibe a mensagem RESP antes de da sub rotina IMPRIME para evitar a repetição da mesma funcionalinade
              LEA  DX, RESP
              MOV  AH, 09
              INT  21H

              CALL IMPRIME      ;Leva até a subrotina "IMPRIME" para impressão do VETOR, nesse caso, apenas exibindo o vetor inserido;

    ;Finaliza o programa
              MOV  AH,4Ch
              INT  21h
MAIN ENDP
LER_VETOR PROC
    ;Lê caracteres inseridos os coloca em suas respetivas posições dentro do vetor
    ;Entrada <- Vetor Zerado
    ;Saida -> Vetor prenchido

    ;Preparação para o LOOP Ler
              MOV  CX,7
              LEA  SI, L1
                  
    Ler:      
    ;Exbibe mensagem de pergunta
              LEA  DX,MG1
              MOV  AH,09
              INT  21H
    ;"Scanf", le o caracter
              MOV  AH,1
              INT  21h
              MOV  DL,AL
    ;Coloca o valor inserido no vetor em seu respetivo elemento
              MOV  [SI],DX      ;Armazena o numero do usuario no vetor, por meio de DX -> Lista[Determinada posição]
              ADD  SI, 2        ;Incrementa SI em 2, para mudar a posição (2 pois foi utilizado DW)
              LOOP Ler

              RET               ;Retorna a função principal
LER_VETOR ENDP

INVERTE PROC
    ;Inverte o vetor inserido
    ;Entrada da varivel vetor
    ;Saida: a variavel vetor invertida
              MOV  CX,3         ;Contador de vezes (Equivalente o número de elementos)
              MOV  SI, 12
              LEA  BX, L1
    Invert:   
              MOV  AX,[BX]      ;Move o valor que está em L1[BX] para AX
              XCHG AX,L1[SI]    ;Troca o valor que está em L1[SI(Começa no ultimo elemento)]
              MOV  [BX],AX
              SUB  SI,2         ;Decrementa SI
              ADD  BX,2         ;Incrementa BX

              LOOP Invert
              RET               ;Retorna a função principal
INVERTE ENDP
IMPRIME PROC
    ;Imprime o vetor que foi inserido depois o invertido
    ;Entrada da varivel vetor
    ;Não há saida
              MOV  CX,7         ;Contador de vezes (Equivalente o número de elementos)
              LEA  SI, L1       ;SI aponta para o primeiro elemento de L1. Podemos usar DI, ou seja, SI=0

    Imprim:   
              MOV  DX, [SI]     ;Insere o valor do elemento de determinada posição do vetor em DX
              OR   DL, 30H      ;Transforma em caracter
              MOV  AH, 2        ;Imprime
              INT  21H
              ADD  SI, 2        ;Incrementa SI em 2, para mudar a posição (2 pois foi utilizado DW)
              LOOP Imprim

              RET               ;Retorna a função principal
IMPRIME ENDP

END MAIN

