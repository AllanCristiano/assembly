section .bss
    buffer resb 256           ; Buffer para armazenar o conteúdo lido do arquivo

section .data
    filename db "input.txt", 0  ; Nome do arquivo a ser lido

section .text
    global _start

_start:
    ; Abrir o arquivo
    mov eax, 5                ; syscall número 5 (sys_open)
    mov ebx, filename         ; nome do arquivo
    mov ecx, 0                ; modo de leitura
    int 0x80                  ; chamada de sistema
    mov ebx, eax              ; salvar o file descriptor

    ; Verificar se o arquivo foi aberto com sucesso
    cmp ebx, -1
    je _error

read_file:
    ; Ler o conteúdo do arquivo
    mov eax, 3                ; syscall número 3 (sys_read)
    mov ecx, buffer           ; buffer para armazenar os dados lidos
    mov edx, 256              ; número máximo de bytes a serem lidos
    int 0x80                  ; chamada de sistema
    cmp eax, 0                ; verificar se chegou ao final do arquivo
    je close_file             ; se chegou ao final do arquivo, fecha o arquivo

    ; Escrever o conteúdo lido na saída padrão
    mov edx, eax              ; número de bytes lidos
    mov eax, 4                ; syscall número 4 (sys_write)
    mov ebx, 1                ; file descriptor 1 (stdout)
    mov ecx, buffer           ; ponteiro para o buffer
    int 0x80                  ; chamada de sistema

    jmp read_file             ; continuar lendo o arquivo

close_file:
    ; Fechar o arquivo
    mov eax, 6                ; syscall número 6 (sys_close)
    mov ebx, eax              ; file descriptor
    int 0x80                  ; chamada de sistema

    ; Saída do programa
    mov eax, 1                ; syscall número 1 (sys_exit)
    xor ebx, ebx              ; código de saída 0
    int 0x80                  ; chamada de sistema

_error:
    ; Código de erro (arquivo não aberto)
    mov eax, 1                ; syscall número 1 (sys_exit)
    mov ebx, 1                ; código de saída 1
    int 0x80                  ; chamada de sistema
