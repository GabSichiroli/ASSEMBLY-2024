TITLE LABTESTE9
.MODEL SMALL
.stack 0100h
.DATA
    MG1   DB 13,10,'Insira o valor da posicao do seu vetor:', '$'
    INSER DB 13,10,'O vetor inserido foi: ','$'
    RESP  DB 13,10,'E seu resultado invertido: ','$'
    LISTA DW 7 DUP (0)
.CODE
MAIN PROC
                  MOV  AX,@DATA
                  MOV  DS,AX

                  XOR  BX,BX
                  MOV  CX, 7            ;contador inicializado no. de elementos
               
    EMPILHALER:   
                  LEA  DX,MG1
                  MOV  AH,09
                  INT  21H
                  MOV  AH,1
                  INT  21h
                  MOV  DL,AL
                  MOV  LISTA[BX],DX     ;Armazena o numero do usuario no vetor, por meio de DX -> Lista[Determinada posição]
                  PUSH LISTA[BX]
                  ADD  BX,2
                  LOOP EMPILHALER       ;faz o laco até CX = 0

                  LEA  DX, INSER
                  MOV  AH, 09
                  INT  21H

                  XOR  DX, DX           ;Inicializando DX
                  MOV  CX,7             ;Contador de vezes (Equivalente o número de elementos)
                  LEA  SI, LISTA        ;SI aponta para o primeiro elemento de L1. Podemos usar DI, ou seja, SI=0

    IMPVINSER:    
                  MOV  DX, [SI]         ;Insere o valor do elemento de determinada posição do vetor em DX
                  OR   DL, 30H          ;Transforma em caracter
                  MOV  AH, 2
                  INT  21H
                  ADD  SI, 2            ;Incrementa SI em 2, para mudar a posição

                  LOOP IMPVINSER        ;Faz o laco até CX = 0

                  LEA  DX, RESP
                  MOV  AH, 09
                  INT  21H


                  XOR  BX,BX            ;Inicializando BX
                  MOV  CX,7
                  MOV  BP,SP

    DESEMPILHA:   

                  MOV  DX,[BP]          ;Insere o valor do elemento de determinada posição da pilha em DX
                  MOV  LISTA[BX],DX     ;Insere o valor DX(Que agora contem o valor do elemento da pilha) em respectivo elemento do vetor. OBS: Pilha[0]=7 L1[0]=1
                  ADD  BP,2             ;Incrementa BP em 2, para mudar a posição de Pilha
                  ADD  BX,2             ;Incrementa BX em 2, para mudar a posição de L1(Vetor)

                  LOOP DESEMPILHA
   
    ;Preparação para o LOOP IMPVINSER:
                  XOR  DX, DX           ;Inicializando DX
                  MOV  CX,7             ;Contador de vezes (Equivalente o número de elementos)
                  LEA  SI, LISTA        ;SI aponta para o primeiro elemento de L1. Podemos usar DI, ou seja, SI=0

    IMPVINVERTIDO:
                  MOV  DX, [SI]         ;Insere o valor do elemento de determinada posição do vetor em DX
                  OR   DL, 30H          ;Transforma em caracter
                  MOV  AH, 2
                  INT  21H
                  ADD  SI, 2            ;Incrementa SI em 2, para mudar a posição

                  LOOP IMPVINVERTIDO    ;Faz o laco até CX = 0

    ; Termina o programa
                  MOV  AH,4CH
                  INT  21H
MAIN ENDP
END MAIN  