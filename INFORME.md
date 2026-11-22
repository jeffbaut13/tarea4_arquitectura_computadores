# Computer Architecture — Practical Assignment 4

## Cover page

- **Course:** Computer Architecture
- **Course code:** 202016893
- **Assignment:** Task 4 — Simulated Practical Component
- **Student:** Jefersson Andres Bautista Vega
- **Date:** November 22, 2026

## Introduction

This practice implements three independent 16-bit DOS programs in MASM/TASM
assembly language. The exercises demonstrate byte arithmetic, Boolean bit
masks, and conditional repetition. Each program uses the small memory model,
initializes the data segment, receives or prints characters through DOS
interrupt `21h`, and returns control to DOS with function `4Ch`.

The source files are organized in separate folders so each exercise can be
assembled and tested independently. The console evidence is kept in the local
`screenshots/` folder and is intentionally excluded from the source repository.
Precompiled DOS executables are also included beside each source file, so the
programs can be tested in DOSBox without separately obtaining an assembler.
The source code and this report are published at
<https://github.com/jeffbaut13/tarea4_arquitectura_computadores>. A Spanish
execution and testing guide is available in `GUIA_EJECUCION.md`.

## General objective

Design and run MASM/TASM assembly programs that demonstrate arithmetic,
logical, and control-flow operations through processor registers and DOS
services.

## Specific objectives

1. Parse two hexadecimal bytes and apply native `ADD` or `SUB` while reporting
   carry or borrow.
2. Apply one of three logical masks (`AND`, `OR`, or `XOR`) to an input byte
   and print the transformed value as eight binary digits.
3. Use a register-controlled loop and conditional branches to print every
   hexadecimal digit from `0` through `F`.
4. Validate input and return an explicit DOS exit code on success or invalid
   input.

## Technical development and evidence

### Program 1 — Direct hexadecimal arithmetic

Source and DOS executable: `programa1-aritmetica/aritmetica.asm` and
`programa1-aritmetica/aritmetica.exe`.

The input helper reads exactly two hexadecimal characters per operand,
converts each nibble, and combines them into a byte. `AL` carries the first
operand and `ADD` or `SUB` performs the operation. Addition retains the
processor carry flag and prints a leading `1` when the result needs a ninth
bit. Subtraction checks the carry flag as the unsigned borrow indicator; when
the second operand is larger, it prints the negative sign and the magnitude.
`AH=01h` reads characters and `AH=09h` prints `$`-terminated messages.

**Representative test:** `F0 + 30` produces `120h` with carry; `10 - 21`
produces `-11h` with borrow.

**Execution evidence to capture:** `screenshots/01_program1_suma.png` and
`screenshots/02_program1_resta.png`.

### Program 2 — Logical mask operator

Source and DOS executable: `programa2-mascaras/mascaras.asm` and
`programa2-mascaras/mascaras.exe`.

The program accepts a byte and an operation selector. `AND 0Fh` clears the
high nibble, `OR 80h` sets the most significant bit, and `XOR 0Fh` toggles the
low nibble. The byte is shifted one bit at a time; the carry flag exposes the
outgoing most-significant bit and is converted into an ASCII `0` or `1`.
Exactly eight result bits are printed.

**Representative tests:** `3A AND 0Fh` produces `00001010`;
`25 OR 80h` produces `10100101`; `3A XOR 0Fh` produces `00110101`.

**Execution evidence to capture:** `screenshots/03_program2_and.png`,
`screenshots/04_program2_or.png`, and `screenshots/05_program2_xor.png`.

### Program 3 — Automatic base-16 counter

Source and DOS executable: `programa3-contador/contador.asm` and
`programa3-contador/contador.exe`.

`BL` holds the current value and `CX` is initialized to 16 iterations.
`CMP` and `JBE` select the ASCII conversion for decimal digits versus `A`–`F`.
After each output, `BL` advances and `CMP`/`JNZ` determine whether a separator
should be printed; `LOOP` controls the repetition. The final output contains
the sequence `0 1 2 3 4 5 6 7 8 9 A B C D E F`.

**Execution evidence to capture:** `screenshots/06_program3_contador.png`.

## Demonstration video

**Public video link:** Pending. The student must record and publish a video
(maximum five minutes) showing their face and explaining one selected exercise,
the registers used, the DOS interrupts, and a live execution.

## Technical conclusions

1. `ADD` and `SUB` make arithmetic status flags directly observable; the carry
   flag also distinguishes an unsigned subtraction borrow.
2. Hexadecimal input requires validating each nibble before combining them,
   which avoids silently accepting values outside the byte range.
3. Bitwise masks alter selected bits without changing unrelated bits, while
   the carry flag can serialize a byte into its eight-bit binary display.
4. `CX`, `LOOP`, and conditional jumps provide a compact way to control a
   finite sequence and format its final element differently.
5. Explicit data-segment initialization and `INT 21h / AH=4Ch` provide a
   predictable DOS program lifecycle for all three exercises.

## References

Rocabado Moreno, S. H., & Arias Figueroa, D. A. (2016). *Arquitectura y
organización de la computadora: microprocesadores y programación assembler*
(pp. 14–70). Editorial de la Universidad Nacional de La Plata.

Open Watcom. (n.d.). *JWasm and UASM assembler documentation*. Open Watcom
Assembler project.

IBM. (1986). *IBM personal computer technical reference*.
