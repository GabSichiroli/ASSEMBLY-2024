TITLE Converção de Bases
MODEL SMALL
.stack 0100h

ImprimeMGS macro OPC1,OP2,OP3,MSGPRIN
               LEA DX, OPC1
               MOV AH,09
               INT 21H

               LEA DX, OP2
               MOV AH,09
               INT 21H

               LEA DX, OP3
               MOV AH,09
               INT 21H

               LEA DX, MSGPRIN
               MOV AH,09
               INT 21H
ENDM

ESCOLHEBASE macro OPC, PROCED

                LEA  DX, OPC
                MOV  AH,09
                INT  21h
                CALL PROCED
ENDM



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

    VETOR      DB 1, 1, 1, 2, 2, 2
    MSGENT     DB 13,10,'Insira a sua base entrada conforme as seguintes opcoes a cima:',13,10,'$'
    MSGSAIDA   DB 13,10,'Insira a sua base saida conforme as seguintes opcoes a cima:',13,10,'$'
    MSGDEC     DB 13,10,'1-Decimal','$'
    MSGLSB     DB 13,10,'2-Binario','$'
    MSGHEXA    DB 13,10,'3-Hexadecimal','$'
    ERROINT    DB 13,10,'A base inserida nao foi encontrada, tente novamente','$'
    MSGCONTROL DB 13,10,'OK','$'
    MSGINSER   DB 13,10,'Insira o valor desejado:',13,10,'$'
.CODE
    ;Programa Principal;
MAIN PROC
    ;Acesso ao DATA
                  MOV         AX, @DATA
                  MOV         DS,AX
      
                  CALL        ESCOLHEENT                        ;Leva até a subrotina "VOLTA" para impressão do VETOR

                  CALL        ESCOLHESAI

                  MOV         AH,4CH
                  INT         21H                               ;saida para o DOS
MAIN ENDP
ESCOLHEENT PROC
                  JMP         Mensagens

    ENTHEX:       
                  ESCOLHEBASE MSGHEXA, LER_HEXA
                  JMP         RETORNA
    ENTLSB:       
                  ESCOLHEBASE MSGLSB, LER_BINARIO
                  JMP         RETORNA
    ENTDEC:       
                  ESCOLHEBASE MSGDEC, LER_DECIMAL
                  JMP         RETORNA
    Error:        
                  LEA         DX, ERROINT
                  MOV         AH,09
                  INT         21H
                  JMP         Mensagens
    Mensagens:    
                  pula_linha
                  LEA         DX, MSGCONTROL
                  MOV         AH,09
                  INT         21H
                  pula_linha

                  ImprimeMGS  MSGDEC,MSGLSB,MSGHEXA,MSGENT

                  MOV         AH,1
                  INT         21h
                  pula_linha
                  CMP         AL, 30H
                  JBE         Error
                  CMP         AL,33h
                  JA          Error
                  JE          ENTHEX
                  CMP         AL,32h
                  JE          ENTLSB
                  CMP         AL,31h
                  JE          ENTDEC
                  
    RETORNA:      
                  RET

ESCOLHEENT ENDP

LER_BINARIO PROC
                  MOV         CX,16
                  XOR         BX,BX

                  LEA         DX,MSGINSER
                  MOV         AH,09
                  INT         21h

                  MOV         AH,01
                  INT         21h
    LerLSB:       
                  CMP         AL,0Dh                            ;é CR?
                  JE          RETLSB
                  AND         AL,0Fh                            ;se não, elimina 30h do caractere
                  SHL         BX,1
                  OR          BL,AL
                  INT         21h                               ;entra novo caractere
                  LOOP        LerLSB
                  
    RETLSB:       
                  RET
LER_BINARIO ENDP

LER_DECIMAL PROC

                  RET
LER_DECIMAL ENDP

LER_HEXA PROC

                  LEA         DX,MSGINSER
                  MOV         AH,09
                  INT         21h
                  XOR         BX,BX
                  XOR         AX,AX
                  JMP         LerHexa
    NEGHEX:       
                  NEG         BX
                  JMP         RETHEXA
    LerHexa:      
                  XOR         DX,DX
                  MOV         CX,5
                  MOV         AH,01
                  INT         21H
    LoopHexa:     
                  CMP         AL,0Dh                            ;é CR?
    ;JE          RETHEXA
                  JE          CONTROL
                  MOV         BL,AL
                  PUSH        BX
                  INT         21H
                  INC         DL
                  LOOP        LoopHexa

                  pula_linha
    CONTROL:      
                  MOV         CX,DX
                  XOR         DX,DX
                  XOR         BX,BX
                
                  MOV         AH,02
    IMPCONTROLE:  
                  POP         BX
                  MOV         DX,BX
                  PUSH        BX
                  INT         21H
                  LOOP        IMPCONTROLE
                  JMP TRANSFOMAÇÕES
    CARNUM:  
    SUB         BX,30H
    JMP         CONVERTHEXLSB1    
    MAIUS:        
                  SUB         BX,31H
                  JMP         CONVERTHEXLSB1
    MINUSC:       
                  SUB         BX,51H
                  JMP         CONVERTHEXLSB1
    LETRA:        
                  CMP         BX,46H
                  JBE         MAIUS
                  CMP         BX,66H
                  JBE         MINUSC
    
    
    TRANSFOMAÇÕES:
                  POP         BX
                  CMP         BX,39H
                  JA          LETRA
                  JBE         CARNUM

    CONVERTHEXLSB1:
    MOV CX,4
    MOV AX,2
    XOR DX,DX
    CONVERTHEXLSB2:
    PUSH AX
    DIV BX
    PUSH DX
    MOV BX, AX
    POP AX
    LOOP CONVERTHEXLSB2

    


    RETHEXA:      
                  RET
LER_HEXA ENDP



ESCOLHESAI PROC

                  JMP         MensagensS

    ENTHEXS:      

                  LEA         DX, MSGHEXA
                  MOV         AH,09
                  INT         21h
                  JMP         RETORNAS
    ENTLSBS:      
                  ESCOLHEBASE MSGLSB, SAI_BINARIO
                  JMP         RETORNAS
    ENTDECS:      

                  LEA         DX, MSGHEXA
                  MOV         AH,09
                  INT         21h
                  JMP         RETORNAS

    ErrorS:       
                  LEA         DX, ERROINT
                  MOV         AH,09
                  INT         21H
                  JMP         MensagensS
    MensagensS:   

                  ImprimeMGS  MSGDEC,MSGLSB,MSGHEXA,MSGSAIDA

                  MOV         AH,1
                  INT         21h
                  pula_linha
                  CMP         AL, 30H
                  JBE         ErrorS
                  CMP         AL,33h
                  JA          ErrorS
                  JE          ENTHEXS
                  CMP         AL,32h
                  JE          ENTLSBS
                  CMP         AL,31h
                  JE          ENTDECS
    RETORNAS:     
                  RET

ESCOLHESAI ENDP
SAI_BINARIO PROC
    ImprimirLSB:  
                  pula_linha
                  MOV         CX,16                             ;inicializa contador de bits
                  MOV         AH,02h                            ;prepara para exibir no monitor
    PT1:          
                  ROL         BX,1                              ;desloca BX 1 casa à esquerda
                  JNC         PT2                               ;salta se CF = 0
                  MOV         DL, 31h                           ;como CF = 1
                  INT         21h                               ;exibe na tela "1" = 31h
                  JMP         PT3
    PT2:          
                  MOV         DL, 30h                           ;como CF = 0
                  INT         21h                               ;exibe na tela "0" = 30h
    PT3:          
                  LOOP        PT1                               ;repete 16 vezes
                  RET

SAI_BINARIO ENDP
END MAIN