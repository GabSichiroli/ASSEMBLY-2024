TITLE PROGRAMA PARA VERIFICACAO DOS FLAGS
;
;usado no DEBUG para verificar o registradores de Flags
;
.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC

         MOV AX,4000H     ;AX = 4000h - valor inicial de AX
         ADD AX,AX        ;AX = 8000h (4000h + 4000h = 8000h)
         SUB AX,0FFFFH    ;AX = 8001h (8000h - FFFFh = 8001h)
         NEG AX           ;AX = 7FFFh (C2 de 8001h)
         INC AX           ;AX = 8000h (7FFFh + 0001h = 8000h)

         MOV AH,4CH
         INT 21H          ;saida para o DOS
MAIN ENDP
END MAIN
