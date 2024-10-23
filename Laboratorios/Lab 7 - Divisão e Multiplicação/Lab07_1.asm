TITLE Ler Vetor
.MODEL SMALL
.stack 0100h
.DATA

    MG1  DB 13,10,'Insira o dividendo:', '$'
    MG2  DB 13,10,'Insira o divisor:', '$'
    MG3  DB 13,10,'Quociente:', '$'
    MG4  DB 13,10,'Resto:', '$'

.CODE
MAIN PROC
    ;Acesso ao DATA
    
         MOV AX,@DATA
         MOV DS,AX
        
         LEA DX, MG1
         MOV AH, 09
         INT 21h
         MOV  AH,1
         INT  21h
         MOV  DL,AL

         LEA DX, MG2
         MOV AH, 09
         INT 21h
         MOV  AH,1
         INT  21h
         MOV  BL,AL

    Divisao:

    SUB DL,BL
    INC CL
    JMP Divisao
        
    ; termina o programa
         MOV AH,4CH
         INT 21H
MAIN ENDP
END MAIN