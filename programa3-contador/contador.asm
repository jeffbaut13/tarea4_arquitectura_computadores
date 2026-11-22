.MODEL SMALL
.STACK 100h

.DATA
heading DB 'Hexadecimal counter from 0h to Fh:',13,10,'$'
newline DB 13,10,'$'

.CODE
main PROC
    mov ax, @DATA
    mov ds, ax

    mov dx, OFFSET heading
    mov ah, 09h
    int 21h

    mov bl, 0
    mov cx, 16
CounterLoop:
    mov dl, bl
    cmp dl, 9
    jbe CounterDigit
    add dl, 'A' - 10
    jmp PrintCounterDigit
CounterDigit:
    add dl, '0'
PrintCounterDigit:
    push cx
    mov ah, 02h
    int 21h
    pop cx

    inc bl
    cmp bl, 10h
    jnz PrintSeparator
    loop CounterLoop
    jmp CounterDone

PrintSeparator:
    push cx
    mov dl, ' '
    mov ah, 02h
    int 21h
    pop cx
    loop CounterLoop

CounterDone:
    mov dx, OFFSET newline
    mov ah, 09h
    int 21h
    mov ax, 4C00h
    int 21h
main ENDP
END main
