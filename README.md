# Tarea 4 — Arquitectura de Computadores

Repositorio: <https://github.com/jeffbaut13/tarea4_arquitectura_computadores>

Implementacion individual de los tres ejercicios de la guia en ensamblador
MASM/TASM, con modelo de memoria `SMALL` y terminacion DOS mediante
`INT 21h / AH=4Ch`.

## Estructura

- `programa1-aritmetica/aritmetica.asm`: suma y resta de bytes hexadecimales.
- `programa1-aritmetica/aritmetica.exe`: ejecutable DOS para probar el programa 1.
- `programa2-mascaras/mascaras.asm`: operaciones AND, OR y XOR con mascaras.
- `programa2-mascaras/mascaras.exe`: ejecutable DOS para probar el programa 2.
- `programa3-contador/contador.asm`: secuencia hexadecimal de `0` a `F`.
- `programa3-contador/contador.exe`: ejecutable DOS para probar el programa 3.
- `INFORME.md`: informe academico en ingles, con pruebas sugeridas y enlace al
  repositorio.
- `GUIA_EJECUCION.md`: instrucciones en espanol para compilar, ejecutar y
  capturar evidencias en DOSBox.
- `screenshots/`: evidencias locales de ejecucion; no se incluye en Git.

No necesitas instalar TASM ni MASM para probarlos: los tres ejecutables DOS
compilados están incluidos junto a sus fuentes. Consulta
[GUIA_EJECUCION.md](GUIA_EJECUCION.md) para abrirlos en DOSBox y los casos de
prueba. TASM/TLINK o MASM/LINK solo hacen falta si deseas volver a compilarlos.

Los PDF de referencia recibidos y las capturas no forman parte del repositorio.
