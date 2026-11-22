# Guía para compilar, ejecutar y tomar las capturas

Esta guía está pensada para macOS con DOSBox Staging. Los fuentes se compilan
dentro de DOSBox con TASM/TLINK o MASM/LINK. DOSBox es solamente el emulador:
necesitas tener los ejecutables del ensamblador y del enlazador en una carpeta
local que puedas usar legalmente. No se distribuyen esas herramientas junto con
el código.

## 1. Preparar las carpetas

1. Descarga o clona este repositorio y ubica la carpeta del proyecto. En este
   equipo, la ruta actual es:
   `/Users/jeferssonbautista/Documents/unad/tarea4-arq-computadores`
2. Coloca `TASM.EXE` y `TLINK.EXE` juntos en una carpeta local, por ejemplo
   `/Users/jeferssonbautista/tasm`. Para MASM, coloca `ML.EXE` y `LINK.EXE`
   juntos en una carpeta local, por ejemplo
   `/Users/jeferssonbautista/masm`.
3. Abre Terminal y ejecuta DOSBox Staging montando el proyecto como `C:` y la
   carpeta del ensamblador como `D:`:

   ```sh
   "$HOME/Applications/DOSBox Staging.app/Contents/MacOS/dosbox" \
     --noprimaryconf \
     -c "mount c /Users/jeferssonbautista/Documents/unad/tarea4-arq-computadores" \
     -c "mount d /Users/jeferssonbautista/tasm" \
     -c "c:"
   ```

   Si usas MASM, reemplaza la ruta de montaje de `D:` por
   `/Users/jeferssonbautista/masm`. En Windows, abre DOSBox, monta la carpeta del
   proyecto con `mount c <ruta-del-proyecto>` y la carpeta de TASM/MASM con
   `mount d <ruta-del-ensamblador>`.

## 2. Compilar y ejecutar con TASM/TLINK

En la consola de DOSBox, escribe estos comandos para el programa 1:

```text
C:
CD \programa1-aritmetica
D:\TASM /m2 aritmetica.asm
D:\TLINK aritmetica.obj
aritmetica.exe
```

Repite para los programas 2 y 3; cambia la carpeta y los nombres:

```text
C:
CD \programa2-mascaras
D:\TASM /m2 mascaras.asm
D:\TLINK mascaras.obj
mascaras.exe
```

```text
C:
CD \programa3-contador
D:\TASM /m2 contador.asm
D:\TLINK contador.obj
contador.exe
```

Si tu distribución ubica los ejecutables en una subcarpeta, ajusta `D:\TASM`
y `D:\TLINK` a sus rutas DOS reales. Al compilar, verifica que no se informen
errores; cada programa queda como un `.EXE` en su carpeta del proyecto.

## 3. Compilar con MASM/LINK (alternativa)

Desde el directorio correspondiente en DOSBox, usa:

```text
D:\ML /c aritmetica.asm
D:\LINK aritmetica.obj
aritmetica.exe
```

Para los otros ejercicios sustituye `aritmetica` por `mascaras` o `contador`.
Si tu versión de MASM requiere opciones o librerías distintas para el enlace,
usa los comandos de su distribución; el programa no depende de bibliotecas de
alto nivel.

## 4. Casos de prueba y resultado esperado

### Programa 1 — Aritmética hexadecimal

Ejecuta `aritmetica.exe` dos veces:

| Primer byte | Segundo byte | Operador | Resultado esperado |
|---|---|---|---|
| `F0` | `30` | `+` | `120h (carry=1)` |
| `10` | `21` | `-` | `-11h (borrow=1)` |

Introduce exactamente dos dígitos hexadecimales para cada byte, y luego el
operador `+` o `-`.

### Programa 2 — Máscaras lógicas

Ejecuta `mascaras.exe` tres veces, ingresa el byte indicado y luego la letra
de operación (A, O o X):

| Byte | Operación | Resultado binario esperado |
|---|---|---|
| `3A` | `A` (AND `0Fh`) | `00001010` |
| `25` | `O` (OR `80h`) | `10100101` |
| `3A` | `X` (XOR `0Fh`) | `00110101` |

### Programa 3 — Contador hexadecimal

Ejecuta `contador.exe`. Debe mostrar una sola línea con los 16 símbolos:

```text
0 1 2 3 4 5 6 7 8 9 A B C D E F
```

## 5. Tomar las capturas

1. Crea una carpeta `screenshots` en la carpeta raíz del proyecto.
2. Captura la ventana de DOSBox cuando se vea el resultado completo de cada
   caso. En macOS, usa `Command + Shift + 4`, luego `Space` y selecciona la
   ventana del emulador.
3. Guarda las imágenes con estos nombres:
   - `01_program1_suma.png`
   - `02_program1_resta.png`
   - `03_program2_and.png`
   - `04_program2_or.png`
   - `05_program2_xor.png`
   - `06_program3_contador.png`
4. Incluye las imágenes en tu copia local del informe si vas a entregar el
   informe completo. La carpeta de capturas está excluida intencionalmente de
   Git y no se sube al repositorio.
