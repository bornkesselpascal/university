# Achtung:
# Unter MinGW muessen alle Funktionen mit einem '_' beginnen.
# Also
# statt main   muss stehen _main
# statt printf muss stehen _printf
#

.data
format_str:
    .asciz "Wert=%d\n"
.text
    .global main
main:
    # Frame einrichten
    # Alten Frame-Pointer sichern und neuen fp setzen
    pushl    %ebp
    movl     %esp, %ebp

    # ------------------------------------------
    # Paramterversorgung fuer printf($format_str,25)
    # Gemaess C-Aufrufkonvention von rechts nach links!
    # Wert 25 auf den Stack legen
    pushl    $25
    # Adresse des Format-Strings auf den Stack legen
    pushl    $format_str
    # Funktion printf der C-Bibliothek aufrufen
    call    printf
    # Stack wieder aufraeumen
    # Zustand vor pushl der Argumente herstellen
    add      $8,%esp

    # ------------------------------------------
    # Paramterversorgung fuer printf($format_str,17)
    # Gemaess C-Aufrufkonvention von rechts nach links!
    # Wert 17 auf den Stack legen
    pushl    $17
    # Adresse des Format-Strings auf den Stack legen
    pushl    $format_str
    # Funktion printf der C-Bibliothek aufrufen
    call     printf
    # Stack wieder aufraeumen
    # Zustand vor pushl der Argumente herstellen
    add      $8,%esp

    # Funktion main mit Wert 0 verlassen
    movl     $0, %eax
    leave
    ret

