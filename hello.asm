; compilação
; nasm -f elf64 exemplo.asm 

; linkeditar -> linguagem de maquina para executavel
; ld -s -o hello hello.o

; executar
; ./hello


section .data
    ; 0xA adicona o caracter de quebra de linha
    msg db "Hello World!", 0xA
    tam equ $- msg

section .text

global _start

_start:

    mov EAX, 0x4; mandar para a saida padrao
    mov EBX, 0x1

    mov ECX, msg
    mov EDX, tam
    int 0x80 ; finalização da mensagem
saida:
    ; finalizar programa
    ; destino , origem -> EAX = 1
    mov EAX, 0x1 ; termino do programa
    mov EBX, 0x0 ; valor de retotorno
    int 0x80 ; finalização da mensagem


