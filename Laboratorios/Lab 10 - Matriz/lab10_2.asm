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

    MATRIZ  DB 4 DUP(4 DUP(0))

    MSG1    DB 13,10,'Insira o elemento de sua matriz(De 0 a 6):','$'
    DNOVO   DB 13,10,'Número maior que 6, tente novamente:','$'
    NMATRIZ DB 13,10,'A matriz inserida foi: ', 13,10,'$'
    SOMA    DB 13,10,'Soma Resultado','$'

.CODE
MAIN PROC
    ;Acesso ao DATA
                 MOV        AX,@DATA
                 MOV        DS,AX

                 CALL       LERMATRIZ
                 LEA        DX, NMATRIZ
                 MOV        AH,09
                 INT        21H
                 CALL       PRINTM                               ;Leva até a subrotina "PRINTM" para impressão do VETOR, nesse caso, apenas exibindo o vetor inserido;
                 CALL       SOMARM

    ;Fim do Programa
                 MOV        AH,4CH                               ; termina o programa
                 INT        21H

MAIN ENDP
LERMATRIZ PROC
                 MOV        SI,SI
                 MOV        BX,BX
                 MOV        CX, 4
    Lerlinha:    
    ;Exbibe mensagem de pergunta
                 LEA        DX,MSG1
                 MOV        AH,09
                 INT        21H
    ;"Scanf", le o caracter
                 MOV        AH,1
                 INT        21h
                 MOV        DL,AL
    ;Coloca o valor inserido no vetor em seu respetivo elemento
                 MOV        MATRIZ[SI][BX],DL                    ; coloca o elemento MATRIZ
    ;CMP        MATRIZ[SI][BX],6
    ;JG         TenteN
                 INC        BX
                 LOOP       Lerlinha
    ;TenteN:
    ;LEA        DX,DNOVO
    ;MOV        AH,09
    ;INT        21H
    ;pula_linha
    ;JMP        Lerlinha

                 XOR        BX, BX                               ; zera o índice da coluna
                 ADD        SI, 4                                ; Muda a linha
                 MOV        CX,4                                 ;Volta o valor de cx para o loop
                 CMP        SI,12                                ; Compara com o numero maximo de linhas se maior
                 pula_linha                                      ;Macro pula linha
                 JBE        Lerlinha
                 RET
LERMATRIZ ENDP
PRINTM PROC
    ;Imprime o vetor que foi inserido depois o invertido
    ;Entrada da varivel matriz
    ;Não há saida
                 XOR        SI, SI                               ; zera o índice da linha
                 XOR        BX, BX                               ; zera o índice da coluna
                 MOV        CX,4
                 MOV        AH, 02H
    IMPRIMELINHA:
                 MOV        DL, MATRIZ[SI][BX]                   ; coloca o elemento MATRIZ4X4[0,0] em AL
                 OR         DL,30H                               ; nUmero em caractere
                 INT        21H
                 INC        BX
                 LOOP       IMPRIMELINHA

                 XOR        BX, BX                               ; zera o índice da coluna
                 ADD        SI, 4                                ; Muda a linha
                 MOV        CX,4                                 ;Volta o valor de cx para o loop
                 CMP        SI,12                                ; Compara com o numero maximo de linhas se maior

                 pula_linha                                      ;Macro pula linha
                 JBE        IMPRIMELINHA
                 RET
PRINTM ENDP
SOMARM PROC

                 XOR        BX,BX
                 XOR        SI,SI
                 XOR        DX,DX
                 MOV        CX,4

    SOMAELEMEN:  
                 MOV        AL, MATRIZ[SI][BX]                   ; coloca o elemento MATRIZ4X4[0,0] em AL
                 SUB        AL,30H
                 ADD        DL,AL
                 INC        BX
                 LOOP       SOMAELEMEN

                 OR         DL,30H                               ; nUmero em caractere
                 MOV        AH, 02H
                 INT        21H                 
                 
                 PUSH       DX
                 XOR DX,DX
                 XOR        BX, BX                               ; zera o índice da coluna
                 ADD        SI, 4                                ; Muda a linha
                 MOV        CX,4                                 ;Volta o valor de cx para o loop
                 CMP        SI,12                                ; Compara com o numero maximo de linhas se maior
                 
                 

                 pula_linha                                      ;Macro pula linha

                 JBE        SOMAELEMEN
                 


                
    ;PUSH       AX
                 RET
                 

SOMARM ENDP

END MAIN