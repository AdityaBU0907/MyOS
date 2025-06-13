[org 0x1000]  ; This is where boot.asm loaded it
bits 16

start:
    mov si, msg
    call puts
    jmp $

puts:
    push si
    push ax
.loop:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0e
    int 0x10
    jmp .loop
.done:
    pop ax
    pop si
    ret

msg: db "Hello from kernel at 0x1000!", 0
