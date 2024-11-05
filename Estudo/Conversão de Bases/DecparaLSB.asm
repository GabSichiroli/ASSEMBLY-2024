TITLE Converção de Bases
MODEL SMALL
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

    MSGENT     DB 13,10,'Insira a entrada decimal:',13,10,'$'
    MSGSAIDA   DB 13,10,'Sua saida binaria eh:',13,10,'$'
    MSGCONTROL DB 13,10,'OK','$'
.CODE
MAIN PROC
    ;Acesso ao DATA
                MOV  AX, @DATA
                MOV  DS,AX
      
                CALL LERDECIMAL     ;Leva até a subrotina "VOLTA" para impressão do VETOR
    ;CALL CONVERTEBINARIO

                MOV  AH,4CH
                INT  21H            ;saida para o DOS
MAIN ENDP
LERDECIMAL PROC
                XOR  BX, BX
                XOR  DX,DX
                XOR  CX,CX
                JMP  Guardasinal

    NSINALIZADO:
                MOV  BX,AX
                PUSH BX
                INC  CX
                JMP  LeNumeros

    MAIS:       
                XOR  DL,DL
                PUSH DX
                JMP  LeNumeros

    MENOS:      
                INC  DL
                PUSH DX
                JMP  LeNumeros

    Guardasinal:

                MOV  AH, 1
                INT  21H
                CMP  AL, 02DH
                JE   MENOS
                CMP  AL, 02BH
                JE   MAIS
                CMP  AL,30H
                JAE  NSINALIZADO

                MOV  AH,1
    LeNumeros:  
                CMP  AL, 0DH
                JE   SOMAEMUM
                MOV  BX,AX
                PUSH BX
                INC  CX
                INT  21h
                JMP  LeNumeros
            
                MOV  AX, 1
                MOV  BP,SP
                MOV  DX,DX
    SOMAEMUM:   
                MOV  BX,[BP]
                PUSH AX
                MUL  BX
                MOV  BX, AX
                PUSH BX
                POP  AX
                MOV  BX,AX
                MOV  AX,10
                MUL  BX
                POP BX
                XOR DX,DX
                POP DX
                ADD DX,BX
                PUSH DX
                ADD  BP, 2
                LOOP SOMAEMUM

                MOV  AX, 2
                XOR  BX,BX

    ConvertLSB: 
                MOV  BX,DX
                AND  AL,0Fh
                PUSH AX
                DIV  BX
                SHL  BX, 1
                OR   BL,DL
                SHL  BX, 1
                MOV  DX, BX
                SHL  BX, 2
                ADD  BX, DX
                ADD  BX, AX
    FIM_DEC:    
                RET
LERDECIMAL ENDP
    ;CONVERTEBINARIO PROC
    ;RET
    ;CONVERTEBINARIO ENDP
end main
