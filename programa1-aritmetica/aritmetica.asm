.MODEL SMALL
.STACK 100h

.DATA
promptA       DB 'First byte (two hex digits, 00-FF): $'
promptB       DB 13,10,'Second byte (two hex digits, 00-FF): $'
promptOp      DB 13,10,'Operation (+ or -): $'
resultLabel   DB 13,10,'Result: $'
carryLabel    DB ' (carry=1)$'
noCarryLabel  DB ' (carry=0)$'
borrowLabel   DB ' (borrow=1)$'
noBorrowLabel DB ' (borrow=0)$'
invalidInput  DB 13,10,'Invalid input. Enter exactly two hexadecimal digits and use + or -.',13,10,'$'
newline       DB 13,10,'$'
firstByte     DB 0
secondByte    DB 0
arithOp       DB 0
resultByte    DB 0
carryFlag     DB 0
borrowFlag    DB 0

.CODE
main PROC
    mov ax, @DATA
    mov ds, ax

    mov dx, OFFSET promptA
    call PrintString
    call ReadHexByte
    jc Invalid
    mov firstByte, al

    mov dx, OFFSET promptB
    call PrintString
    call ReadHexByte
    jc Invalid
    mov secondByte, al

    mov dx, OFFSET promptOp
    call PrintString
    call ReadChar
    mov arithOp, al
    cmp al, '+'
    je DoAddition
    cmp al, '-'
    je DoSubtraction
    jmp Invalid

DoAddition:
    mov al, firstByte
    add al, secondByte
    mov resultByte, al
    mov carryFlag, 0
    jnc ShowResult
    mov carryFlag, 1
    jmp ShowResult

DoSubtraction:
    mov al, firstByte
    sub al, secondByte
    mov resultByte, al
    mov borrowFlag, 0
    jnc ShowResult
    mov borrowFlag, 1
    mov al, secondByte
    sub al, firstByte
    mov resultByte, al

ShowResult:
    mov dx, OFFSET resultLabel
    call PrintString

    cmp arithOp, '+'
    jne PrintSubtraction
    cmp carryFlag, 0
    je PrintAdditionValue
    mov dl, '1'
    mov ah, 02h
    int 21h

PrintAdditionValue:
    mov al, resultByte
    call PrintHexByte
    mov dl, 'h'
    mov ah, 02h
    int 21h
    mov dx, OFFSET newline
    call PrintString
    cmp carryFlag, 0
    je PrintNoCarry
    mov dx, OFFSET carryLabel
    call PrintString
    jmp ExitSuccess
PrintNoCarry:
    mov dx, OFFSET noCarryLabel
    call PrintString
    jmp ExitSuccess

PrintSubtraction:
    cmp borrowFlag, 0
    je PrintSubtractionValue
    mov dl, '-'
    mov ah, 02h
    int 21h

PrintSubtractionValue:
    mov al, resultByte
    call PrintHexByte
    mov dl, 'h'
    mov ah, 02h
    int 21h
    mov dx, OFFSET newline
    call PrintString
    cmp borrowFlag, 0
    je PrintNoBorrow
    mov dx, OFFSET borrowLabel
    call PrintString
    jmp ExitSuccess
PrintNoBorrow:
    mov dx, OFFSET noBorrowLabel
    call PrintString
    jmp ExitSuccess

Invalid:
    mov dx, OFFSET invalidInput
    call PrintString
    mov ax, 4C01h
    int 21h

ExitSuccess:
    mov ax, 4C00h
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
    cmp al, '0'
    jb HexInvalid
    cmp al, '9'
    jbe HexDecimal
    and al, 0DFh
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

PrintHexByte PROC
    push bx
    mov bl, al
    mov al, bl
    shr al, 1
    shr al, 1
    shr al, 1
    shr al, 1
    call PrintHexDigit
    mov al, bl
    and al, 0Fh
    call PrintHexDigit
    pop bx
    ret
PrintHexByte ENDP

PrintHexDigit PROC
    push ax
    cmp al, 9
    jbe HexDigitNumeric
    add al, 7
HexDigitNumeric:
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h
    pop ax
    ret
PrintHexDigit ENDP

END main
