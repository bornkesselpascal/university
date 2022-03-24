#---------------------------------------------------
# Erzeuge Assemblercode aus einem C-Programm

Mit folgendem Kommando kann man das
C-Programm hello.c
in Intel-Assemblercode übersetzen.

gcc -S -masm=intel  -Wall hello.c

Danach einfach die Assemblerdatei hello.s betrachten.

#-----------------------
# Hinweis:
# Die Assembler-Dateien hello_att.s und hello_intel.s sind
# manuell kodierte Assemblerdateien.
