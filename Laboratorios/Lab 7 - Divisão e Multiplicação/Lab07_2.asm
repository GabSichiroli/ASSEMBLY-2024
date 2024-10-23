TITLE Ler Vetor
.MODEL SMALL
.stack 0100h
.DATA

    MG1   DB 13,10,'Insira o valor da posicao do seu vetor:', '$'
    RESP  DB 13,10,'E seu resultado invertido: ','$'

.CODE
MAIN PROC
    ;Acesso ao DATA

         MOV AX,@DATA
         MOV DS,AX
         MOV AH,4CH      ; termina o programa
         INT 21H
MAIN ENDP
END MAIN