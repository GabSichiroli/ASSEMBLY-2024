TITLE LabV9P3
.MODEL SMALL
.stack 0100h
.DATA

    MG1   DB 13,10,'Insira o valor da posicao do seu vetor:', '$'
    INSER DB 13,10,'O vetor inserido foi: ','$'
    RESP  DB 13,10,'E seu resultado invertido: ','$'
    LISTA DW 0,0,0,0,0,0,0 

.CODE
MAIN PROC
    ;Acesso ao DATA
               MOV  AX,@DATA
               MOV  DS,AX


    ;Preparação para o LOOP Ler:
               XOR  SI,SI           ;Inicializando SI
               MOV  CX, 7           ;Contador de vezes (Equivalente o número de elementos)

Ler:       
    ;Exibe a MG1
               LEA  DX,MG1
               MOV  AH,09
               INT  21H

    ;Função de inserir o caracter
               MOV  AH,1
               INT  21h
               MOV  DL,AL

    ;Insere o valor de DX em L1 na posição referida
               MOV  LISTA[SI],DX    ;Armazena o numero do usuario no vetor, por meio de DX -> Lista[Determinada posição]
               ADD  SI, 2           ;Incrementa SI em 2, para mudar a posição (2 pois foi utilizado DW)

               LOOP Ler             ;Faz o laco até CX = 0
        
    ;Exibe a INSER
               LEA  DX, INSER
               MOV  AH, 09
               INT  21H

    ;Preparação para o LOOP IMPVINSER:
               XOR  DX, DX          ;Inicializando DX
               MOV  CX,7            ;Contador de vezes (Equivalente o número de elementos)
               LEA  SI, LISTA       ;SI aponta para o primeiro elemento de L1. Podemos usar DI, ou seja, SI=0

IMPVINSER: 
               MOV  DX, [SI]        ;Insere o valor do elemento de determinada posição do vetor em DX
               OR   DL, 30H         ;Transforma em caracter
               MOV  AH, 2
               INT  21H
               ADD  SI, 2           ;Incrementa SI em 2, para mudar a posição

               LOOP IMPVINSER       ;Faz o laco até CX = 0

    ;Parte da inversão:

    ;Exibe a RESP
               LEA  DX, RESP
               MOV  AH, 09
               INT  21H

    ;Preparação para o LOOP EMPILHA:
               XOR  BX,BX           ;Inicializando BX
               MOV  CX, 7           ;Contador de vezes (Equivalente o número de elementos)
               
EMPILHA:   
               PUSH LISTA[BX]       ;PUXA o elemento para o começo da pilha
               ADD  BX,2            ;Incrementa BX em 2, para mudar a posição de L1

               LOOP EMPILHA         ;Faz o laco até CX = 0

    ;Preparação para o LOOP DESEMPILHA:
               XOR  BX,BX           ;Inicializando BX
               MOV  CX,7            ;Contador de vezes (Equivalente o número de elementos)
               MOV  BP,SP           ;BP aponta para o primeiro elemento de da pilha, ou seja, BP=0

DESEMPILHA:

               MOV  DX,[BP]         ;Insere o valor do elemento de determinada posição da pilha em DX
               MOV  LISTA[BX],DX    ;Insere o valor DX(Que agora contem o valor do elemento da pilha) em respectivo elemento do vetor. OBS: Pilha[0]=7 L1[0]=1
               ADD  BP,2            ;Incrementa BP em 2, para mudar a posição de Pilha
               ADD  BX,2            ;Incrementa BX em 2, para mudar a posição de L1(Vetor)

               LOOP DESEMPILHA
   
    ;Preparação para o LOOP IMPVINSER:
               XOR  DX, DX          ;Inicializando DX
               MOV  CX,7            ;Contador de vezes (Equivalente o número de elementos)
               LEA  SI, LISTA       ;SI aponta para o primeiro elemento de L1. Podemos usar DI, ou seja, SI=0

IMPVINVERTIDO: 
               MOV  DX, [SI]        ;Insere o valor do elemento de determinada posição do vetor em DX
               OR   DL, 30H         ;Transforma em caracter
               MOV  AH, 2
               INT  21H
               ADD  SI, 2           ;Incrementa SI em 2, para mudar a posição

               LOOP IMPVINVERTIDO      ;Faz o laco até CX = 0

    ; Termina o programa
               MOV  AH,4CH
               INT  21H
MAIN ENDP
END MAIN  