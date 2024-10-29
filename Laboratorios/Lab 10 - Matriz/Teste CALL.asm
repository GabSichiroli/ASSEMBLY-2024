TITLE Matriz
.MODEL SMALL
.stack 0100h
pula_linha macro
               PUSH AX
               PUSH DX
               MOV  AH,02
               MOV  DL,10
               INT  21H
               POP  DX
               POP  AX
endm

.DATA

    MATRIZ  DB 1,2,3,4
            DB 4,3,2,1
            DB 5,6,7,8
            DB 8,7,6,5

    NMATRIZ DB 13,10,'A MATRIZ = ', 13,10, '$'
.CODE
MAIN PROC
    ;Acesso ao DATA
            MOV        AX,@DATA
            MOV        DS,AX
            LEA        DX, NMATRIZ
            MOV        AH,09
            INT        21H
            XOR        BX,BX               ; zera o índice da linha
            MOV CX,4
    Imprimel:
            CALL       PRINTM                ;Leva até a subrotina "PRINTM" para impressão do VETOR, nesse caso, apenas exibindo o vetor inserido;
            ADD BX,4
            pula_linha ;Macro pula linha
            LOOP Imprimel

    ;Fim do Programa
            MOV        AH,4CH                ; termina o programa
            INT        21H

MAIN ENDP
PRINTM PROC
    ;Imprime o vetor que foi inserido depois o invertido
    ;Entrada da varivel matriz
    ;Não há saida
            XOR        SI,SI               ; zera o índice da coluna
            MOV DI,4
            MOV        AH, 02H
    IMPRIMELINHA:
            MOV        DL, MATRIZ[BX][SI]    ; coloca o elemento MATRIZ4X4[0,0] em AL
            OR         DL,30H                ; nUmero em caractere
            INT        21H
            INC        SI
            CMP SI,DI
            JB   IMPRIMELINHA
            RET
PRINTM ENDP
END MAIN