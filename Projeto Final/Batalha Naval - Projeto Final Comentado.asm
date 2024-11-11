TITLE Batalha Naval - Projeto Final
.MODEL SMALL
.stack 0100h

IMPLOGO macro PART1,PART2,PART3,PART4,PART5,MSGPRIN
;IMPRIME A LOGO DO JOGO BATALHA NAVAL(A capa do trabalho)
               LEA DX, PART1
               MOV AH,09
               INT 21H

               LEA DX, PART2
               MOV AH,09
               INT 21H

               LEA DX, PART3
               MOV AH,09
               INT 21H

               LEA DX, PART4
               MOV AH,09
               INT 21h

               LEA DX, PART5
               MOV AH,09
               INT 21H

               LEA DX, MSGPRIN
               MOV AH,09
               INT 21H
ENDM

.DATA
      MATRIZ  DW 0,0,0,0,0,0,1,1,1,0     ,     1,1,1,0,0,0,0,0,0,0
              DW 0,0,1,0,0,0,0,1,0,0     ,     0,0,0,0,1,0,0,0,0,0
              DW 0,0,1,0,0,0,0,0,0,0     ,     0,0,0,1,1,0,0,0,0,0
              DW 0,0,0,0,0,0,0,1,0,0     ,     0,0,0,0,1,0,1,1,0,0
              DW 0,0,0,0,0,0,0,1,1,0     ,     0,0,0,0,0,0,0,0,0,0
              DW 0,0,0,0,0,0,0,1,0,0     ,     1,1,1,1,0,0,0,0,0,0
              DW 1,1,1,0,0,0,0,0,0,0     ,     0,0,0,0,0,0,0,1,0,0
              DW 0,0,0,0,0,1,1,0,0,0     ,     1,1,0,0,0,0,0,1,1,0
              DW 0,0,0,0,0,0,0,0,0,0     ,     0,0,0,0,0,0,0,1,0,0
              DW 1,1,1,1,0,0,0,0,0,0     ,     0,0,0,0,0,0,0,0,0,0

              DW 0,0,0,0,0,0,0,0,0,0     ,     0,0,0,0,0,0,0,0,0,0
              DW 0,0,0,0,0,0,0,0,0,0     ,     0,0,0,0,0,0,0,0,0,0
              DW 0,0,0,0,0,0,0,0,0,0     ,     0,0,0,0,0,0,0,0,0,0
              DW 0,0,0,0,0,0,0,0,0,0     ,     0,0,0,0,0,0,0,0,0,0
              DW 0,0,0,0,0,0,0,0,0,0     ,     0,0,0,0,0,0,0,0,0,0
              DW 0,0,0,0,0,0,0,0,0,0     ,     0,0,0,0,0,0,0,0,0,0
              DW 0,0,0,0,0,0,0,0,0,0     ,     0,0,0,0,0,0,0,0,0,0
              DW 0,0,0,0,0,0,0,0,0,0     ,     0,0,0,0,0,0,0,0,0,0
              DW 0,0,0,0,0,0,0,0,0,0     ,     0,0,0,0,0,0,0,0,0,0
              DW 0,0,0,0,0,0,0,0,0,0     ,     0,0,0,0,0,0,0,0,0,0

      VETOR   DB 10 DUP (0)
      ;Mensagens;
      ;Pagina Inicial;
      LOGO1   DB 13,10,'             ===================================================             ', '$'
      LOGO2   DB 13,10,'             =                                                 =            ', '$'
      LOGO3   DB 13,10,'             =     Batalha     Naval     Em     Assembly       =            ','$'
      LOGO4   DB 13,10,'             =                                                 =            ','$'
      LOGO5   DB 13,10,'             ===================================================             ', 13,10, '$'
      ENTMSG1 DB 13,10,'               Insira ate 3 numeros de 0-9 para iniciar o jogo:', '$'

.CODE
MAIN PROC
      ;Acesso ao DATA
              MOV  AX, @DATA
              MOV  DS,AX
              CALL INICIAR
      ;Termina o programa
              MOV  AH,4CH
              INT  21H
MAIN ENDP
INICIAR PROC
        XOR BX,BX
        XOR DX,DX
        
IMPLOGO LOGO1, LOGO2, LOGO3, LOGO4, LOGO5, ENTMSG1

              MOV  AH,1

              INT  21h
              MOV  DL,AL

              RET
INICIAR ENDP
END MAIN