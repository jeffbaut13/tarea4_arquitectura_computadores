# Guía para compilar, ejecutar y tomar las capturas

Esta guía está pensada para macOS con DOSBox Staging. **No necesitas buscar ni
descargar `TASM.EXE`, `TLINK.EXE`, `ML.EXE` ni `LINK.EXE` para probar esta
entrega.** Esos nombres son herramientas de ensamblado y enlace, no son los
tres programas de la tarea. Los tres ejecutables DOS ya compilados
(`aritmetica.exe`, `mascaras.exe` y `contador.exe`) están incluidos en sus
carpetas junto al código fuente. Basta con abrirlos con DOSBox siguiendo el
paso 1 y continuar con la sección 2.

TASM/TLINK son herramientas antiguas de Borland y MASM/LINK pertenecen a la
cadena de herramientas de Microsoft para Windows. No es necesario instalar
ninguna de ellas para realizar las pruebas de esta guía.

## 1. Preparar las carpetas

1. Descarga o clona este repositorio y ubica la carpeta del proyecto. En este
   equipo, la ruta actual es:
   `/Users/jeferssonbautista/Documents/unad/tarea4-arq-computadores`
2. Abre Terminal y ejecuta DOSBox Staging montando el proyecto como `C:`:

   ```sh
   "$HOME/Applications/DOSBox Staging.app/Contents/MacOS/dosbox" \
     --noprimaryconf \
     -c "mount c /RUTA/AL/PROYECTO" \
     -c "c:"
   ```

   Sustituye `/RUTA/AL/PROYECTO` por la ruta donde está la carpeta descargada
   (en este equipo, `/Users/jeferssonbautista/Documents/unad/tarea4-arq-computadores`).
   En Windows, abre DOSBox y monta esa carpeta con
   `mount c <ruta-del-proyecto>`.

## 2. Ejecutar los programas incluidos

En la consola de DOSBox, ejecuta cada programa desde su carpeta:

```text
C:
CD \programa1-aritmetica
aritmetica.exe
```

```text
C:
CD \programa2-mascaras
mascaras.exe
```

```text
C:
CD \programa3-contador
contador.exe
```

## 3. Casos de prueba y resultado esperado

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

## 4. Tomar las capturas

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

## 5. Volver a compilar (opcional)

Solo necesitas esta sección si modificas los fuentes. Se requiere un
ensamblador compatible con MASM/TASM y un enlazador OMF configurados en DOS.
Por ejemplo, con TASM/TLINK instalados en una unidad `D:`, desde la carpeta de
cada fuente ejecuta `D:\TASM /m2 nombre.asm` y `D:\TLINK nombre.obj`. Las
herramientas no se incluyen en el repositorio. Después de compilar, ejecuta el
`.EXE` generado como se muestra arriba.
