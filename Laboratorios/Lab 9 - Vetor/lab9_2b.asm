TITLE PROGRAMA EXEMPLO PARA MANIPULAÇÃO DE VETORES USANDO SI ou DI
.MODEL SMALL
.DATA
    VETOR DB 1, 1, 1, 2, 2, 2
.CODE
MAIN PROC
    ;Acesso ao DATA
          MOV  AX, @DATA
          MOV  DS,AX

          MOV  CX,6             ;Contador de vezes (Equivalente o número de elementos)
          XOR  DI, DI           ;Inicializando DI (Pode usar SI)

    ;IMPRIMI O VETOR
    VOLTA:

          MOV  DL, VETOR[DI]    ;Insere o valor do elemento de determinada posição do vetor em DL, a posição do vetor é determinado pelo valor de DI, OU SEJA VETOR[0],VETOR[1]...VETOR[6]
          INC  DI               ;Incrementa DI (DI++) para mudar a posição (DI anterior +1)
          ADD  DL, 30H          ;Transforma em caracter
          MOV  AH, 02           ;Imprime
          INT  21H

          LOOP VOLTA            ;Faz o laco até CX = 0

    ;Termina o programa
          MOV  AH,4CH
          INT  21H
MAIN ENDP
END MAIN
