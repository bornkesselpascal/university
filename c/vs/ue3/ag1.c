#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/sem.h>
#include <stdbool.h>

void reader(size_t process);
void writer(size_t process);

void init_sem(int sem_num, int sem_init);
void P(int sem_num);
void V(int sem_num);
int getval(int sem_num);
void setval(int sem_num, int sem_val);

const int sem_writer = 0;
const int sem_reader = 1;
const int sem_mutex = 2;

int sem_id;
volatile int critical = 0;

int main(void)
{
    int sem_key;
    if ((sem_key = ftok("/home/bornk/Dokumente/Developer/university/c/vs/ue3", '1')) < 0)
    {
        perror("Fehler bei ftok");
        exit(1);
    }

    if ((sem_id = semget(sem_key, 3, IPC_CREAT | 0666)) < 0)
    {
        perror("Fehler bei semget");
        exit(1);
    }

    // Writer-Semaphore
    init_sem(sem_writer, 1);
    // Reader-Semaphore
    init_sem(sem_reader, 5);
    // Mutex-Semaphore
    init_sem(sem_mutex, 1);

    // Erstellung der SCHREIBER
    for (size_t process = 0; process < 2; process++)
    {
        switch (fork())
        {
        case -1:
            perror("Erzeugung fehlgeschlagen");
            exit(1);

        case 0:
            // Kindprozess
            printf("Schreiber: %ld\tPID: %d\n", process, getpid());
            writer(process);
            exit(0);

        default:
            // Vaterprozess
            break;
        }
    }

    // Erstellung der LESER
    for (size_t process = 0; process < 5; process++)
    {
        switch (fork())
        {
        case -1:
            perror("Erzeugung fehlgeschlagen");
            exit(1);

        case 0:
            // Kindprozess
            printf("Leser: %ld\tPID: %d\n", process, getpid());
            reader(process);
            exit(0);

        default:
            // Vaterprozess
            break;
        }
    }
}

void reader(size_t process)
{
    for (size_t i = 0; i < 3; i++)    
    {
        // Zugriff auf Variable
        P(sem_mutex);
        {
            P(sem_reader);
            if (4 == getval(sem_reader))
            {
                P(sem_writer);
            }
            printf("Leser %ld: Es lesen gerade %d Leser.\n", process, (5-getval(sem_reader)));
        }
        V(sem_mutex);

        {
            printf("Leser %ld: Prozess liest Variable.\n",process);
            sleep(rand() % 5);
        }

        P(sem_mutex);
        {
            V(sem_reader);
            if (5 == getval(sem_reader))
            {
                printf("Leser %ld: Keine weiteren Leser.\n", process);
                V(sem_writer);
            }
        }
        V(sem_mutex);

        sleep(1);


        // Unkritischer Bereich
        printf("Leser %ld: Prozess im unkritischen Bereich.\n", process);
        sleep(1);
    }
}

void writer(size_t process)
{
    for (size_t i = 0; i < 3; i++)  
    {
        // Zugriff auf Variable
        printf("Schreiber %ld: Prozess möchte schreiben.\n", process);
        P(sem_writer);
        printf("Schreiber %ld: Prozess darf schreiben.\n", process);

        {
            printf("Schreiber %ld: Variable beschrieben.\n", process);
        }

        printf("Schreiber %ld: Schreiben beendet.\n", process);
        V(sem_writer);

        sleep(1);


        // Unkritischer Bereich
        printf("Schreiber %ld: Prozess im unkritischen Bereich.\n", process);
        sleep(1);
    }
}

void init_sem(int sem_num, int sem_init)
{
    if (semctl(sem_id, sem_num, SETVAL, sem_init) < 0)
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
    semaphore.sem_flg = ~(IPC_NOWAIT | SEM_UNDO);

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
    semaphore.sem_flg = ~(IPC_NOWAIT | SEM_UNDO);

    if (semop(sem_id, &semaphore, 1))
    {
        perror("Fehler bei semop V()");
        exit(1);
    }
}

int getval(int sem_num)
{
    int semval = semctl(sem_id, sem_num, GETVAL, 0);

    if (semval < 0)
    {
        perror("Fehler bei semctl");
        exit(1);
    }

    return semval;
}

void setval(int sem_num, int sem_val)
{
    init_sem(sem_num, sem_val);
}