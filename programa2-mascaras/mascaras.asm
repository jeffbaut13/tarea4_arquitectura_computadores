.MODEL SMALL
.STACK 100h

.DATA
promptValue DB 'Enter a byte (two hex digits, 00-FF): $'
promptOp    DB 13,10,'Operation [A=AND, O=OR, X=XOR]: $'
andLabel    DB 13,10,'AND 0Fh result (8-bit binary): $'
orLabel     DB 13,10,'OR 80h result (8-bit binary): $'
xorLabel    DB 13,10,'XOR 0Fh result (8-bit binary): $'
invalidText DB 13,10,'Invalid input. Enter two hex digits and choose A, O, or X.',13,10,'$'
newline     DB 13,10,'$'
inputByte   DB 0
resultByte  DB 0
operation   DB 0

.CODE
main PROC
    mov ax, @DATA
    mov ds, ax

    mov dx, OFFSET promptValue
    call PrintString
    call ReadHexByte
    jc Invalid
    mov inputByte, al

    mov dx, OFFSET promptOp
    call PrintString
    call ReadChar
    and al, 0DFh
    mov operation, al

    cmp al, 'A'
    je ApplyAnd
    cmp al, 'O'
    je ApplyOr
    cmp al, 'X'
    je ApplyXor
    jmp Invalid

ApplyAnd:
    mov al, inputByte
    and al, 0Fh
    mov resultByte, al
    mov dx, OFFSET andLabel
    jmp ShowBinary

ApplyOr:
    mov al, inputByte
    or al, 80h
    mov resultByte, al
    mov dx, OFFSET orLabel
    jmp ShowBinary

ApplyXor:
    mov al, inputByte
    xor al, 0Fh
    mov resultByte, al
    mov dx, OFFSET xorLabel

ShowBinary:
    call PrintString
    call PrintBinaryByte
    mov dx, OFFSET newline
    call PrintString
    mov ax, 4C00h
    int 21h

Invalid:
    mov dx, OFFSET invalidText
    call PrintString
    mov ax, 4C01h
    int 21h
main ENDP

PrintString PROC
    mov ah, 09h
    int 21h
    ret
PrintString ENDP

ReadChar PROC
ReadCharAgain:
    mov ah, 01h
    int 21h
    cmp al, 13
    je ReadCharAgain
    ret
ReadChar ENDP

ReadHexByte PROC
    push bx
    call ReadChar
    call HexToNibble
    jc ReadHexInvalid
    shl al, 1
    shl al, 1
    shl al, 1
    shl al, 1
    mov bl, al
    call ReadChar
    call HexToNibble
    jc ReadHexInvalid
    or al, bl
    clc
    pop bx
    ret
ReadHexInvalid:
    pop bx
    stc
    ret
ReadHexByte ENDP

HexToNibble PROC
    and al, 0DFh
    cmp al, '0'
    jb HexInvalid
    cmp al, '9'
    jbe HexDecimal
    cmp al, 'A'
    jb HexInvalid
    cmp al, 'F'
    ja HexInvalid
    sub al, 'A'
    add al, 10
    clc
    ret
HexDecimal:
    sub al, '0'
    clc
    ret
HexInvalid:
    stc
    ret
HexToNibble ENDP

PrintBinaryByte PROC
    push ax
    push bx
    push cx
    push dx
    mov bl, resultByte
    mov cx, 8
BinaryBit:
    shl bl, 1
    mov dl, '0'
    adc dl, 0
    mov ah, 02h
    int 21h
    loop BinaryBit
    pop dx
    pop cx
    pop bx
    pop ax
    ret
PrintBinaryByte ENDP

END main
