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
Pula_linha macro
                   PUSH AX
                   PUSH DX
                   MOV  AH,02
                   MOV  DL,10
                   INT  21H
                   POP  DX
                   POP  AX
endm

Controle_Programa macro CONTROLE
                          LEA DX, CONTROLE
                          MOV AH,09
                          INT 21H
ENDM
.DATA
        MATRIZTESTE  DB 1, 2, 3, 4, 5, 6, 7, 8, 9
                     DB 1, 2, 3, 4, 5, 6, 7, 8, 9
                     DB 1, 2, 3, 4, 5, 6, 7, 8, 9
                     DB 1, 2, 3, 4, 5, 6, 7, 8, 9
                     DB 1, 2, 3, 4, 5, 6, 7, 8, 9
                     DB 1, 2, 3, 4, 5, 6, 7, 8, 9
                     DB 1, 2, 3, 4, 5, 6, 7, 8, 9
                     DB 1, 2, 3, 4, 5, 6, 7, 8, 9
                     DB 1, 2, 3, 4, 5, 6, 7, 8, 9
                     DB 1, 2, 3, 4, 5, 6, 7, 8, 9
                     DB 1, 2, 3, 4, 5, 6, 7, 8, 9
                     DB 1, 2, 3, 4, 5, 6, 7, 8, 9
                     DB 1, 2, 3, 4, 5, 6, 7, 8, 9
                     DB 1, 2, 3, 4, 5, 6, 7, 8, 9
                     DB 1, 2, 3, 4, 5, 6, 7, 8, 9
                     DB 1, 2, 3, 4, 5, 6, 7, 8, 9
                     DB 1, 2, 3, 4, 5, 6, 7, 8, 9
                     DB 1, 2, 3, 4, 5, 6, 7, 8, 9
                     DB 1, 2, 3, 4, 5, 6, 7, 8, 9
                     DB 1, 2, 3, 4, 5, 6, 7, 8, 9


        MATRIZ       DB 0,0,0,0,0,0,1,1,1,0     ,     1,1,1,0,0,0,0,0,0,0
                     DB 0,0,1,0,0,0,0,1,0,0     ,     0,0,0,0,1,0,0,0,0,0
                     DB 0,0,1,0,0,0,0,0,0,0     ,     0,0,0,1,1,0,0,0,0,0
                     DB 0,0,0,0,0,0,0,1,0,0     ,     0,0,0,0,1,0,1,1,0,0
                     DB 0,0,0,0,0,0,0,1,1,0     ,     0,0,0,0,0,0,0,0,0,0
                     DB 0,0,0,0,0,0,0,1,0,0     ,     1,1,1,1,0,0,0,0,0,0
                     DB 1,1,1,0,0,0,0,0,0,0     ,     0,0,0,0,0,0,0,1,0,0
                     DB 0,0,0,0,0,1,1,0,0,0     ,     1,1,0,0,0,0,0,1,1,0
                     DB 0,0,0,0,0,0,0,0,0,0     ,     0,0,0,0,0,0,0,1,0,0
                     DB 1,1,1,1,0,0,0,0,0,0     ,     0,0,0,0,0,0,0,0,0,0

                     DB 0,0,0,0,0,0,0,0,0,0     ,     0,0,0,0,0,0,0,0,0,0
                     DB 0,0,0,0,0,0,0,0,0,0     ,     0,0,0,0,0,0,0,0,0,0
                     DB 0,0,0,0,0,0,0,0,0,0     ,     0,0,0,0,0,0,0,0,0,0
                     DB 0,0,0,0,0,0,0,0,0,0     ,     0,0,0,0,0,0,0,0,0,0
                     DB 0,0,0,0,0,0,0,0,0,0     ,     0,0,0,0,0,0,0,0,0,0
                     DB 0,0,0,0,0,0,0,0,0,0     ,     0,0,0,0,0,0,0,0,0,0
                     DB 0,0,0,0,0,0,0,0,0,0     ,     0,0,0,0,0,0,0,0,0,0
                     DB 0,0,0,0,0,0,0,0,0,0     ,     0,0,0,0,0,0,0,0,0,0
                     DB 0,0,0,0,0,0,0,0,0,0     ,     0,0,0,0,0,0,0,0,0,0
                     DB 0,0,0,0,0,0,0,0,0,0     ,     0,0,0,0,0,0,0,0,0,0

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
                      CALL              PRINTMT
        ;CALL              PRINTM
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

                      JE                CompENT
                      MOV               DL,AL
                      SUB               DL,30H
                      ADD               BL, DL
                      INT               21h
                      LOOP              LerEnt

        CompENT:      
                      CMP               BL, '4'
                      JB                RetornaEnt

        DivDerminadaM:
                      MOV               AX, 04h
                      DIV               BX
        CompQUA:      
                      CMP               DX, '0'
                      JE                QUA4
                      CMP               DX, '1'
                      JE                QUA1
                      CMP               DX, '2'
                      JE                QUA2
                      CMP               DX, '3'
                      JE                QUA3
        QUA1:         

                      Controle_Programa MSGCONTROLE
                      JMP               RetornaEnt

        QUA2:         

                      Controle_Programa MSGCONTROLE1
                      JMP               RetornaEnt
        QUA3:         

                      Controle_Programa MSGCONTROLE2
                      JMP               RetornaEnt
        QUA4:         

                      Controle_Programa MSGCONTROLE3
                      JMP               RetornaEnt

        RetornaEnt:   
                      RET
INICIAR ENDP
PRINTMT PROC
        ;Imprime o vetor que foi inserido depois o invertido
        ;Entrada da varivel matriz
        ;Não há saida
                      pula_linha
                      XOR               SI, SI                                            ; zera o índice da linha
                      XOR               BX, BX                                            ; zera o índice da coluna
                      MOV               CX,9
                      JMP L1

        RESTIMP:      
                      XOR               BX, BX                                            ; zera o índice da coluna
                      ADD               SI,4                                             ; Muda a linha
                      MOV               CX,9                                             ;Volta o valor de cx para o loop
                      CMP               SI,8
                      JG               RETORNATEST
        L1:
                      pula_linha 
                      MOV               AH, 02H
        IMPRIMELINHA: 
                      MOV               DL, MATRIZTESTE [SI][BX]                          ; coloca o elemento MATRIZ4X4[0,0] em AL
                      OR                DL,30H                                            ; nUmero em caractere
                      INT               21H
                      INC               BX
                      LOOP              IMPRIMELINHA
                      JMP RESTIMP

                                                                  ; Compara com o numero maximo de linhas se maior
                      
RETORNATEST:
                      RET
PRINTMT ENDP
END MAIN