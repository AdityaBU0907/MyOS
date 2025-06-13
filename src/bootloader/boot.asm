[org 0x7C00]
bits 16

start:
    xor ax, ax
    mov ds, ax
    mov es, ax

    mov si, msg
    call puts

    ; Load 1 sector from drive (kernel) at 0x1000
    mov ah, 0x02        ; BIOS read sector
    mov al, 1           ; number of sectors
    mov ch, 0           ; cylinder
    mov cl, 2           ; sector 2 (sector 1 = boot)
    mov dh, 0           ; head
    mov dl, 0           ; drive (0 = floppy)
    mov bx, 0x1000      ; where to load
    mov es, ax
    int 0x13
    jc fail

    jmp 0x0000:0x1000

fail:
    mov si, err
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

msg: db "Loading kernel...", 0
err: db "Disk read error", 0

times 510 - ($ - $$) db 0
dw 0xAA55
