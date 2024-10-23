TITLE Vetor versão 2
.MODEL SMALL
.DATA
    NSOMA DB 13,10,'A SOMA = ', '$'
    LISTA DW 0,1,2,1,0,0,1,1,1,1
.CODE
MAIN PROC
         MOV  AX,@DATA
         MOV  DS,AX
         XOR  BX,BX           ;inicializa AX com zero
         XOR  SI,SI
         MOV  CX, 10          ;contador inicializado no. de elementos
    SOMA:
         ADD  BX,LISTA[SI]    ;acumula AX com o elemento de LISTA apontado por SI
         ADD  SI,2            ;movimenta o ponteiro para o próximo
         LOOP SOMA            ;faz o laço até CX = 0
         LEA  DX, NSOMA       ; imprime mensagem NSOMA
         MOV  AH,09
         INT  21H

         MOV  DX,BX
         OR   DL,30H          ; número em caractere
         MOV  AH,2            ; imprime a soma
         INT  21H

         MOV  AH,4CH          ; termina o programa
         INT  21H
MAIN ENDP
END MAIN

