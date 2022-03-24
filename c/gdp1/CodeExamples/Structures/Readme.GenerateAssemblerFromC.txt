#---------------------------------------------------
# Erzeuge Assemblercode aus einem C-Programm

Mit folgendem Kommando kann man das
C-Programm students-V3.c
in Intel-Assemblercode übersetzen.

gcc -S -masm=intel  -Wall students-V3.c

Danach einfach die Assemblerdatei students-V3.s betrachten.

