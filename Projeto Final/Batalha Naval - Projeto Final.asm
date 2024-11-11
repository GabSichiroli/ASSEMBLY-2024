TITLE Batalha Naval - Projeto Final
.MODEL SMALL
.stack 0100h
IMPLOGO macro PART1,PART2,PART3,PART4,PART5,MSGPRIN
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

Controle_Programa macro CONTROLE
                          LEA DX, CONTROLE
                          MOV AH,09
                          INT 21H
ENDM
.DATA
        MATRIZ       DW 0,0,0,0,0,0,1,1,1,0     ,     1,1,1,0,0,0,0,0,0,0
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

        VETOR        DB 10 DUP (0)
        ;Mensagens;
        ;Pagina Inicial;
        LOGO1        DB 13,10,'             ===================================================             ', '$'
        LOGO2        DB 13,10,'             =                                                 =            ', '$'
        LOGO3        DB 13,10,'             =     Batalha     Naval     Em     Assembly       =            ','$'
        LOGO4        DB 13,10,'             =                                                 =            ','$'
        LOGO5        DB 13,10,'             ===================================================             ', 13,10, '$'
        ENTMSG1      DB 13,10,'              Insira ate 3 numeros de 0-9 para iniciar o jogo:', '$'
        MSGCONTROLE  DB 13,10,'OK', '$'
        MSGCONTROLE1 DB 13,10,'OK1', '$'
        MSGCONTROLE2 DB 13,10,'OK2', '$'
        MSGCONTROLE3 DB 13,10,'OK3', '$'


.CODE
MAIN PROC
        ;Acesso ao DATA
                      MOV               AX, @DATA
                      MOV               DS,AX
                      CALL              INICIAR
        ;Termina o programa
                      MOV               AH,4CH
                      INT               21H
MAIN ENDP
INICIAR PROC

                     

                      IMPLOGO           LOGO1, LOGO2, LOGO3, LOGO4, LOGO5, ENTMSG1

                      MOV               CX, 3 
                      XOR               BX,BX
                      XOR               DX,DX
                      MOV               AH,1

        LerEnt:       
                      CMP               AL, 0DH

                      JE                DivDerminadaM
                      MOV               DL,AL
                      AND               DL,0Fh                                            ;se não, elimina 30h do caractere
                      ADD               BL, DL
                      INT               21h
                      LOOP              LerEnt

        CompENT:      
                      CMP               BL, 4h
                      JB                RetornaEnt

        DivDerminadaM:
                      MOV               AX, 4h
                      DIV               BL
        CompQUA:      
                      CMP               AH, 0h
                      JE                QUA4
                      CMP               AH, 1h
                      JE                QUA1
                      CMP               AH, 2h
                      JE                QUA2
                      CMP               AH, 3h
                      JE                QUA3
        QUA1:

        Controle_Programa MSGCONTROLE
        JMP RetornaEnt

        QUA2:

        Controle_Programa MSGCONTROLE1
        JMP RetornaEnt
        QUA3:

        Controle_Programa MSGCONTROLE2
        JMP RetornaEnt
        QUA4:

        Controle_Programa MSGCONTROLE3
        JMP RetornaEnt

        RetornaEnt:   
                      RET
INICIAR ENDP
END MAIN