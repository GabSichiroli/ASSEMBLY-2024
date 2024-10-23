TITLE Batalha Naval - Projeto Final
.stack 0100h
.MODEL SMALL
.DATA
      VETOR DB 10 DUP (0)
.CODE
MAIN PROC
      ;Acesso ao DATA
            MOV  AX, @DATA
            MOV  DS,AX

      ;Termina o programa
            MOV  AH,4CH
            INT  21H
MAIN ENDP
END MAIN