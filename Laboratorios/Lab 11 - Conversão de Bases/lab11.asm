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
MAIN PROC
      ;Acesso ao DATA
                  MOV        AX, @DATA
                  MOV        DS,AX
      
                  CALL       ESCOLHE_ENT                         ;Leva até a subrotina "VOLTA" para impressão do VETOR
                  CALL       ESCOLHE_SAI

                  MOV        AH,4CH
                  INT        21H                                 ;saida para o DOS
MAIN ENDP
ESCOLHE_ENT PROC

                  XOR        AL, AL
                  CMP        AL,0
                  JZ         Mensagens

      ENTHEX:     

                  LEA        DX, MSGHEXA
                  MOV        AH,09
                  INT        21h
                  CALL       LER_HEXA
                  JMP        RETORNA
      ENTLSB:     

                  LEA        DX, MSGLSB
                  MOV        AH,09
                  INT        21h
                  CALL       LER_BINARIO
                  JMP        RETORNA
      ENTDEC:     

                  LEA        DX, MSGHEXA
                  MOV        AH,09
                  INT        21h
                  CALL       LER_DECIMAL
                  JMP        RETORNA

      Error:      
                  LEA        DX, ERROINT
                  MOV        AH,09
                  INT        21H
                  JMP        Mensagens
      Mensagens:  

                  ImprimeMGS MSGDEC,MSGLSB,MSGHEXA,MSGENT

                  MOV        AH,1
                  INT        21h
                  pula_linha
                  CMP        AL, 30H
                  JBE        Error
                  CMP        AL,33h
                  JA         Error
                  JE         ENTHEX
                  CMP        AL,32h
                  JE         ENTLSB
                  CMP        AL,31h
                  JE         ENTDEC
                  
      RETORNA:    
                  RET

ESCOLHE_ENT ENDP

LER_BINARIO PROC
                  MOV        CX,16
                  XOR        BX,BX

                  LEA        DX,MSGINSER
                  MOV        AH,09
                  INT        21h

                  MOV        AH,01
                  INT        21h
      LerLSB:     
                  CMP        AL,0Dh                              ;é CR?
                  JE         RETORNA1
                  AND        AL,0Fh                              ;se não, elimina 30h do caractere
                  SHL        BX,1
                  OR         BL,AL
                  INT        21h                                 ;entra novo caractere
                  LOOP       LerLSB
                  
      RETORNA1:   
                  PUSH       BX
                  RET
LER_BINARIO ENDP

LER_DECIMAL PROC

                  RET
LER_DECIMAL ENDP

LER_HEXA PROC
                  RET
LER_HEXA ENDP



ESCOLHE_SAI PROC

                  XOR        AL, AL
                  CMP        AL,0
                  JZ         Mensagens

      ENTHEXS:    

                  LEA        DX, MSGHEXA
                  MOV        AH,09
                  INT        21h
                  JMP        RETORNA
      ENTLSBS:    

                  LEA        DX, MSGLSB
                  MOV        AH,09
                  INT        21h
                  CALL       SAI_BINARIO
                  JMP        RETORNA
      ENTDECS:    

                  LEA        DX, MSGHEXA
                  MOV        AH,09
                  INT        21h
                  JMP        RETORNA

      ErrorS:     
                  LEA        DX, ERROINT
                  MOV        AH,09
                  INT        21H
                  JMP        Mensagens
      MensagensS: 

                  ImprimeMGS MSGDEC,MSGLSB,MSGHEXA,MSGSAIDA

                  MOV        AH,1
                  INT        21h
                  pula_linha
                  CMP        AL, 30H
                  JBE        ErrorS
                  CMP        AL,33h
                  JA         ErrorS
                  JE         ENTHEXS
                  CMP        AL,32h
                  JE         ENTLSBS
                  CMP        AL,31h
                  JE         ENTDECS
                  
      RETORNAS:   
                  RET

ESCOLHE_SAI ENDP

SAI_BINARIO PROC

      POP BX

      ImprimirLSB:
                  MOV        CX,16                               ;inicializa contador de bits
                  MOV        AH,02h                              ;prepara para exibir no monitor
      PT1:        
                  ROL        BX,1                                ;desloca BX 1 casa à esquerda
                  JNC        PT2                                 ;salta se CF = 0
                  MOV        DL, 31h                             ;como CF = 1
                  INT        21h                                 ;exibe na tela "1" = 31h
                  JMP        PT3
      PT2:        
                  MOV        DL, 30h                             ;como CF = 0
                  INT        21h                                 ;exibe na tela "0" = 30h
      PT3:        
                  LOOP       PT1                                 ;repete 16 vezes


                  RET

SAI_BINARIO ENDP
END MAIN