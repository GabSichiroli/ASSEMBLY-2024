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
                  MOV  AX,@DATA
                  MOV  DS,AX


    ;Preparação para o LOOP Ler:
                  XOR  SI,SI            ;Inicializando SI
                  MOV  CX, 7            ;Contador de vezes (Equivalente o número de elementos)

    Ler:          
    ;Exibe a MG1
                  LEA  DX,MG1
                  MOV  AH,09
                  INT  21H

    ;Função de inserir o caracter
                  MOV  AH,1
                  INT  21h
                  MOV  DL,AL

    ;Insere o valor de DX em L1 na posição referida
                  MOV  L1[BX],DX        ;Armazena o numero do usuario no vetor, por meio de DX -> Lista[Determinada posição]
                  ADD  BX, 2            ;Incrementa SI em 2, para mudar a posição (2 pois foi utilizado DW)

                  LOOP Ler              ;Faz o laco até CX = 0
        
    ;Exibe a INSER
                  LEA  DX, INSER
                  MOV  AH, 09
                  INT  21H

    ;Preparação para o LOOP IMPVINSER:
                  XOR  DX, DX           ;Inicializando DX
                  MOV  CX,7             ;Contador de vezes (Equivalente o número de elementos)
                  LEA  BX, L1

    IMPVINSER:    
                  MOV  DX, [BX]         ;Insere o valor do elemento de determinada posição do vetor em DX
                  OR   DL, 30H          ;Transforma em caracter
                  MOV  AH, 2
                  INT  21H
                  ADD  BX, 2            ;Incrementa SI em 2, para mudar a posição

                  LOOP IMPVINSER        ;Faz o laco até CX = 0


                  MOV  CX,3             ;Contador de vezes (Equivalente o número de elementos)
                  XOR  SI,SI
                  ADD  SI, 12
                  LEA  BX, L1           ; BX aponta para o primeiro elemento de VETOR. Podemos usar DI

    Invert:       
                  MOV  AX,[BX]          ;Move o valor que está em L1[BX] para AX
                  XCHG AX,L1[SI]        ;Troca o valor que está em L1[SI(Começa no ultimo elemento)] 
                  MOV  [BX],AX
                  SUB  SI,2
                  ADD  BX,2

                  LOOP Invert

                  LEA  DX, RESP
                  MOV  AH, 09
                  INT  21H


    ;Preparação para o LOOP IMPVINSER:
                  MOV  CX,7             ;Contador de vezes (Equivalente o número de elementos)
                  LEA  SI, L1           ;SI aponta para o primeiro elemento de L1. Podemos usar DI, ou seja, SI=0

    IMPVINVERTIDO:
                  MOV  DX, [SI]         ;Insere o valor do elemento de determinada posição do vetor em DX
                  OR   DL, 30H          ;Transforma em caracter
                  MOV  AH, 2
                  INT  21H
                  ADD  SI, 2            ;Incrementa SI em 2, para mudar a posição

                  LOOP IMPVINVERTIDO    ;Faz o laco até CX = 0

              



                  MOV  AH,4CH           ; termina o programa
                  INT  21H
MAIN ENDP
END MAIN