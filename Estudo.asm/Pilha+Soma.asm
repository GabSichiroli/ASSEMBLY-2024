TITLE vetor  PILHA e SOMA
.MODEL SMALL
.stack 0100h
.DATA
   
    NSOMA DB 13,10,'A SOMA = ', '$'
    LISTA DW 0,1,2,3,4
.CODE
MAIN PROC
               MOV  AX,@DATA
               MOV  DS,AX
    
               XOR  BX,BX
               XOR  SI,SI
               MOV  CX, 5         ;contador inicializado no. de elementos
    EMPILHA:   
    ;ADD BX,[LISTA + SI]    ;acumula AX com o elemento de LISTA apontado por SI
               PUSH LISTA[SI]
               ADD  SI,2
               LOOP EMPILHA       ;faz o laco até CX = 0
               MOV  CX,5
               MOV  BP,SP

    DESEMPSOMA:
               MOV  DX,[BP]
               ADD  BX,DX
               OR   DL,30H        ; numero em caractere
               ADD  BP,2
               MOV  AH,2          ; imprime o caracter
               INT  21H
               LOOP DESEMPSOMA

               LEA  DX, NSOMA
               MOV  AH,09
               INT  21H
               MOV  DX,BX
               OR   DL,30H        ; número em caractere
               MOV  AH,2          ; imprime a soma
               INT  21H


               MOV  AH,4CH        ; termina o programa
               INT  21H
MAIN ENDP
END MAIN

;CONSIDERAÇÕES: ESSE PROGRAMA SÓ POSSIBILITA SOMAS ATÉ 9