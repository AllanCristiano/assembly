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
    x dd 60              ; Define double word -> dd
    y dd 50

    msgX db "X é maior que Y", LF, NULL
    tamX equ $- msgX
    msgY db "Y é maior que X", LF, NULL
    tamY equ $- msgY
    msgE db "X == Y", LF, NULL
    tamE equ $- msgE

section .bss

section .text
    global _start

_start:
    mov eax, DWORD [x]
    mov ebx, DWORD [y]
    ; Comparação de valores
    cmp eax, ebx
    ; Salto condicional
    ; je ==, jg >, jge >=, jl <, jle <=, jne !=
    jg maior  ; eax > ebx
    jl menor  ; eax < ebx

    ; Se for igual
    mov ecx, msgE
    mov edx, tamE
    jmp final

maior:
    mov ecx, msgX
    mov edx, tamX
    jmp final

menor:
    mov ecx, msgY
    mov edx, tamY
    jmp final

final:
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    int SYS_CALL

saida:
    ; Finalizar programa
    mov eax, SYS_EXIT
    mov ebx, RET_EXIT
    int SYS_CALL
