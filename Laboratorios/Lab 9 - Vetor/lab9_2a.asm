TITLE PROGRAMA EXEMPLO PARA MANIPULAÇÃO DE VETORES USANDO SI ou DI
.MODEL SMALL
.DATA
      VETOR DB 1, 1, 1, 2, 2, 2
.CODE
MAIN PROC
      ;Acesso ao DATA
            MOV  AX, @DATA
            MOV  DS,AX

            CALL VOLTA          ;Leva até a subrotina "VOLTA" para impressão do VETOR

      ;Termina o programa
            MOV  AH,4CH
            INT  21H
MAIN ENDP
VOLTA PROC
      ;Imprime o vetor inserido em data
      ;Entrada da varivel vetor
      ;Não há saida
            MOV  CX,6           ;Contador de vezes (Equivalente o número de elementos)
            LEA  SI, VETOR      ; SI aponta para o primeiro elemento de VETOR. Podemos usar DI
      VOLT: 
            MOV  DL, [SI]       ;Insere o valor do elemento de determinada posição do vetor em DL, a posição do vetor é determinado pelo valor de SI, OU SEJA VETOR[0],VETOR[1]...VETOR[6]
            INC  SI             ;Incrementa SI (SI++) para mudar a posição (SI anterior +1)
            ADD  DL, 30H        ;Transforma em caracter
            MOV  AH, 02         ;Imprime
            INT  21H

            LOOP VOLT           ;Faz o laco até CX = 0
            RET                 ;Retorna a função principal
VOLTA ENDP
END MAIN
