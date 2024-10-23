TITLE Vetor versão 2
.MODEL SMALL
.DATA
    NSOMA DB 13,10,'A SOMA = ', '$'
    
    L1    DW 0,1,2,1,1,0,1,1,1,1
    ;L2    DW 0,1,2,1,1,0,1,1,1,1

    ;L1    DW 10 DUP (3)
    L2    DW 10 DUP (1)
.CODE
MAIN PROC
    ;Acesso ao DATA
                  MOV  AX,@DATA
                  MOV  DS,AX

                  XOR  DX, DX          ;Inicializando DX
                  XOR  BX,BX
                  XOR  SI,SI
                  MOV  CX, 10           ;contador inicializado no. de elementos
    SOMA:         
                
                  MOV DX, L1[SI]
                  ADD L2[BX],DX
                  ADD  SI, 2
                  ADD  BX, 2
                  LOOP SOMA

                  XOR  DX, DX           ;Inicializando DX
                  MOV  CX,10            ;Contador de vezes (Equivalente o número de elementos)
                  LEA  SI, L2           ;SI aponta para o primeiro elemento de L1. Podemos usar DI, ou seja, SI=0

    IMPRESULTADO:
                  MOV  DX, [SI]         ;Insere o valor do elemento de determinada posição do vetor em DX
                  OR   DL, 30H          ;Transforma em caracter
                  MOV  AH, 2
                  INT  21H
                  ADD  SI, 2            ;Incrementa SI em 2, para mudar a posição

                  LOOP IMPRESULTADO    ;Faz o laco até CX = 0
                  MOV  AH,4CH           ; termina o programa
                  INT  21H
MAIN ENDP
END MAIN

;CONSIDERAÇÕES: ESSE PROGRAMA SÓ POSSIBILITA SOMAS ATÉ 9
