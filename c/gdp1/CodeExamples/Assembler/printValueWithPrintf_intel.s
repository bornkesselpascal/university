# Achtung:
# Unter MinGW muessen alle Funktionen mit einem '_' beginnen.
# Also
# statt main   muss stehen _main
# statt printf muss stehen _printf
#
# INTEL-Assembler statt AT&T Assembler
# Siehe
# http://en.wikipedia.org/wiki/GNU_Assembler#Usage
# https://www.mirbsd.org/htman/i386/man7/gas-intel-howto.htm
#
    .intel_syntax noprefix

    .data
format_str:
    .asciz "Wert=%d\n"

    .text
    .global main

main:
    # Frame einrichten
    # Alten Frame-Pointer sichern und neuen fp setzen
    push    ebp
    mov     ebp, esp

    # ------------------------------------------
    # Paramterversorgung fuer printf($format_str,25)
    # Gemaess C-Aufrufkonvention von rechts nach links!
    # Wert 25 auf den Stack legen
    push    25
    # Adresse des Format-Strings auf den Stack legen
    push    offset format_str
    # Funktion printf der C-Bibliothek aufrufen
    call    printf
    # Stack wieder aufraeumen
    # Zustand vor push der Argumente herstellen
    add     esp,8

    # ------------------------------------------
    # Paramterversorgung fuer printf($format_str,17)
    # Gemaess C-Aufrufkonvention von rechts nach links!
    # Wert 17 auf den Stack legen
    push    17
    # Adresse des Format-Strings auf den Stack legen
    push    offset format_str
    # Funktion printf der C-Bibliothek aufrufen
    call    printf
    # Stack wieder aufraeumen
    # Zustand vor push der Argumente herstellen
    add     esp,8

    # Funktion main mit Wert 0 verlassen
    mov     eax,0
    leave
    ret

