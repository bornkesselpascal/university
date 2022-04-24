#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void son(size_t process);
void critial(size_t process);
void uncritial(size_t process);

int main(void)
{
    for (size_t process = 0; process < 3; process++)
    {
        switch (fork())
        {
        case -1:
            perror("Erzeugung fehlgeschlagen");
            exit(1);

        case 0:
            // Kindprozess
            printf("Prozess: %ld\tPID: %d\n", process, getpid());
            son(process);
            exit(0);

        default:
            // Vaterprozess
            break;
        }
    }
}

void son(size_t process)
{
    // Kritischer Bereich, 3x durchlaufen
    for (size_t i = 0; i < 3; i++)
    {
        critial(process);
    }
    
    // Unkritischer Bereich, 1x durchlaufen
    uncritial(process);
}

void critial(size_t process)
{
    printf("Prozess %ld betritt den kritischen Bereich.\n", process);
    sleep(1);
    printf("Prozess %ld verlässt den kritischen Bereich.\n", process);
}

void uncritial(size_t process)
{
    printf("Prozess %ld betritt den nicht-kritischen Bereich.\n", process);
    sleep(1);
    printf("Prozess %ld verlässt den nicht-kritischen Bereich.\n", process);
}