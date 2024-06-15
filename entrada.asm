section .data
    LF equ 0xA           ; Line Feed \n
    NULL equ 0x0         ; Final string
    SYS_CALL equ 0x80    ; Envia informação ao SO
    ; Enviados para EAX
    SYS_EXIT equ 0x1     ; Código finalização programa
    SYS_WRITE equ 0x4    ; Operação de escrita
    SYS_READ equ 0x3     ; Operação de leitura
    ; Enviados para EBX
    RET_EXIT equ 0x0     ; Operação realizada
    STD_IN equ 0x0       ; Entrada padrão
    STD_OUT equ 0x1      ; Saída padrão

section .data
    msg db "Entre com seu nome:", LF, NULL
    tam equ $- msg

    saudacao db "Olá, ", NULL  ; Mensagem de saudação
    tam_saudacao equ $- saudacao

section .bss
    nome resb 128        ; Armazena até 128 bytes (maior espaço para entrada)
    saudacao_nome resb 256 ; Buffer para a saudação com o nome

section .text
    global _start

_start:
    ; Imprimir mensagem
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, msg
    mov edx, tam
    int SYS_CALL

    ; Ler entrada
    mov eax, SYS_READ
    mov ebx, STD_IN
    mov ecx, nome
    mov edx, 128         ; Tamanho máximo da entrada
    int SYS_CALL

    ; Remover o caractere LF da entrada
    mov rdi, nome
remover_lf:
    cmp byte [rdi], LF
    je lf_removido
    cmp byte [rdi], NULL
    je lf_removido
    inc rdi
    jmp remover_lf
lf_removido:
    mov byte [rdi], NULL

    ; Construir mensagem de saudação
    mov rdi, saudacao_nome
    mov rsi, saudacao
    call copiar_string
    mov rsi, nome
    call copiar_string

    ; Imprimir saudação
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, saudacao_nome
    mov edx, tam_saudacao + 128
    int SYS_CALL

saida:
    ; Finalizar programa
    mov eax, SYS_EXIT
    mov ebx, RET_EXIT
    int SYS_CALL

copiar_string:
    ; rdi = destino
    ; rsi = fonte
    copiar_byte:
        mov al, [rsi]
        mov [rdi], al
        inc rdi
        inc rsi
        test al, al
        jnz copiar_byte
    ret
