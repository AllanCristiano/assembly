segment .data
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
    STD_OUT equ 0x1  

