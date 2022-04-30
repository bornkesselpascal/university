#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/sem.h>


void son(size_t process);
void critial(size_t process);
void uncritial(size_t process);

void init_sem();
void P(int sem_num);
void V(int sem_num);


int sem_key;
int sem_id;


int main(void)
{
    if ((sem_key = ftok("/home/bornk/Dokumente/Developer/university/c/vs/ue1", '1')) < 0)
    {
        perror("Fehler bei ftok");
        exit(1);
    }

    if ((sem_id = semget(sem_key, 1, IPC_CREAT|0666)) < 0)
    {
        perror("Fehler bei semget");
        exit(1);
    }
    
    init_sem();
    

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
    P(0);
    printf("Prozess %ld betritt den kritischen Bereich.\n", process);
    sleep(1);
    printf("Prozess %ld verlässt den kritischen Bereich.\n", process);
    V(0);
}

void uncritial(size_t process)
{
    printf("Prozess %ld betritt den nicht-kritischen Bereich.\n", process);
    sleep(1);
    printf("Prozess %ld verlässt den nicht-kritischen Bereich.\n", process);
}

void init_sem()
{
    if (semctl(sem_id, 0, SETVAL, 1) < 0)
    {
        perror("Fehler bei semctl");
        exit(1);
    }
}

void P(int sem_num)
{
    struct sembuf semaphore;

    semaphore.sem_num = sem_num;
    semaphore.sem_op = -1;
    semaphore.sem_flg = ~(IPC_NOWAIT|SEM_UNDO);

    if (semop(sem_id, &semaphore, 1))
    {
        perror("Fehler bei semop P()");
        exit(1);
    }
}

void V(int sem_num)
{
    struct sembuf semaphore;

    semaphore.sem_num = sem_num;
    semaphore.sem_op = 1;
    semaphore.sem_flg = ~(IPC_NOWAIT|SEM_UNDO);

    if (semop(sem_id, &semaphore, 1))
    {
        perror("Fehler bei semop P()");
        exit(1);
    }
}