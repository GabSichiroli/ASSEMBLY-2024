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
Pula_linha macro
               PUSH AX
               PUSH DX
               MOV  AH,02
               MOV  DL,10
               INT  21H
               POP  DX
               POP  AX
endm
ImprimeQUA macro VALORCOL,REGVALOR,MATRIZIMP
                 Local      MudaLinha
                 Local      L1
                 Local      IMPRIMELINHA
                 Local      Retornaimp
                 MOV        BX,VALORCOL
                 XOR        SI,SI                  ;Linha
                 MOV        CX,10
                 JMP        L1
    MudaLinha:   
                 MOV        BX,VALORCOL            ; zera o índice da coluna
                 ADD        SI,40                  ; Muda a linha
                 MOV        CX,10                  ;Volta o valor de cx para o loop
                 CMP        SI,REGVALOR
                 JG         Retornaimp
    L1:          
                 pula_linha
                 MOV        AH, 02H
    IMPRIMELINHA:
                 MOV        DX, MATRIZIMP [SI][BX]    ; coloca o elemento MATRIZ4X4[0,0] em AL
                 OR         DL,30H                 ; nUmero em caractere
                 INT        21H
                 ADD        BX,2
                 LOOP       IMPRIMELINHA
                 JMP        MudaLinha
    Retornaimp:  
                 RET
endm
.DATA
    MATRIZ       DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2
                 DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2
                 DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2
                 DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2
                 DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2
                 DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2
                 DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2
                 DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2
                 DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2
                 DW 1,1,1,1,1,1,1,1,1,1     ,     2,2,2,2,2,2,2,2,2,2

                 DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4
                 DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4
                 DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4
                 DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4
                 DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4
                 DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4
                 DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4
                 DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4
                 DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4
                 DW 3,3,3,3,3,3,3,3,3,3     ,     4,4,4,4,4,4,4,4,4,4


    VETOR        DB 10 DUP (0)
    ;Mensagens;
    ;Pagina Inicial;
    LOGO1        DB 13,10,'             ===================================================             ', '$'
    LOGO2        DB 13,10,'             =                                                 =            ', '$'
    LOGO3        DB 13,10,'             =     Batalha     Naval     Em     Assembly       =            ','$'
    LOGO4        DB 13,10,'             =                                                 =            ','$'
    LOGO5        DB 13,10,'             ===================================================             ', 13,10, '$'
    ENTMSG1      DB 13,10,'              Insira ate 3 numeros de 0-9 para iniciar o jogo:', '$'
    MSGCONTROLE  DB 13,10,'OK1', '$'
    MSGCONTROLE1 DB 'OK2', '$'

.CODE
MAIN PROC
    ;Acesso ao DATA
                         MOV        AX, @DATA
                         MOV        DS,AX

                         CALL       INICIAR
                         CALL       IMPRIMEMATRIZINTEIRA

    ;Termina o programa
                         MOV        AH,4CH
                         INT        21H
MAIN ENDP
INICIAR PROC
                         IMPLOGO    LOGO1, LOGO2, LOGO3, LOGO4, LOGO5, ENTMSG1
                         MOV        AH,1
                         INT        21h
                         MOV        DL,AL

                         RET
INICIAR ENDP
IMPRIMEMATRIZINTEIRA PROC
                         MOV        BX,20                                         ;Coluna
                         XOR        SI,SI                                         ;Linha
                         MOV        CX,10
                         JMP        L1
    MudaLinha:           
                         MOV        BX,20                                         ; zera o índice da coluna
                         ADD        SI,40                                         ; Muda a linha
                         MOV        CX,10                                         ;Volta o valor de cx para o loop
                         CMP        SI,360
                         JG         Retornaimp
    L1:                  
                         pula_linha
                         MOV        AH, 02H
    IMPRIMELINHA:        
                         MOV        DX, MATRIZ [SI][BX]                           ; coloca o elemento MATRIZ4X4[0,0] em AL
                         OR         DL,30H                                        ; nUmero em caractere
                         INT        21H
                         ADD        BX,2
                         LOOP       IMPRIMELINHA
                         JMP        MudaLinha
    Retornaimp:          
                         RET
IMPRIMEMATRIZINTEIRA ENDP
END MAIN