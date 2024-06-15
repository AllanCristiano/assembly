section .bss
    name resb 100      ; Reserva 100 bytes para armazenar o nome

section .data
    prompt db "Digite seu nome: ", 0  ; Mensagem de prompt
    prompt_len equ $ - prompt          ; Comprimento da mensagem
    msg db "Olá, ", 0           ; Mensagem para imprimir o nome
    msg_len equ $ - msg                ; Comprimento da mensagem

section .text
    global _start

_start:
    ; Escreve o prompt para o usuário
    mov eax, 4                ; syscall número 4 (sys_write)
    mov ebx, 1                ; file descriptor 1 (stdout)
    mov ecx, prompt           ; ponteiro para a mensagem
    mov edx, prompt_len       ; comprimento da mensagem
    int 0x80                  ; chamada de sistema

    ; Lê o nome do usuário
    mov eax, 3                ; syscall número 3 (sys_read)
    mov ebx, 0                ; file descriptor 0 (stdin)
    mov ecx, name             ; ponteiro para o buffer onde será armazenado o nome
    mov edx, 100              ; número máximo de bytes a serem lidos
    int 0x80                  ; chamada de sistema

    ; Escreve a mensagem "Seu nome é: "
    mov eax, 4                ; syscall número 4 (sys_write)
    mov ebx, 1                ; file descriptor 1 (stdout)
    mov ecx, msg              ; ponteiro para a mensagem
    mov edx, msg_len          ; comprimento da mensagem
    int 0x80                  ; chamada de sistema

    ; Escreve o nome do usuário
    mov eax, 4                ; syscall número 4 (sys_write)
    mov ebx, 1                ; file descriptor 1 (stdout)
    mov ecx, name             ; ponteiro para o nome lido
    mov edx, 100              ; número máximo de bytes a serem escritos (até o '\n')
    int 0x80                  ; chamada de sistema

    ; Saída do programa
    mov eax, 1                ; syscall número 1 (sys_exit)
    xor ebx, ebx              ; código de saída 0
    int 0x80                  ; chamada de sistema
