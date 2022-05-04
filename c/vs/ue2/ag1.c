#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/sem.h>
#include <stdbool.h>


void philosopher(size_t process);
void denken(size_t process);
void essen(size_t process, int gabel_1, int gabel_2);

void init_sem(int sem_num, int sem_init);
void P(int sem_num_1, int sem_num_2);
void V(int sem_num_1, int sem_num_2);


const size_t philosophers = 5;
const size_t turn = 3;


int sem_id;


int main(void)
{
    int sem_key;
    if ((sem_key = ftok("/home/bornk/Dokumente/Developer/university/c/vs/ue2", '1')) < 0)
    {
        perror("Fehler bei ftok");
        exit(1);
    }

    if ((sem_id = semget(sem_key, philosophers, IPC_CREAT|0666)) < 0)
    {
        perror("Fehler bei semget");
        exit(1);
    }

    for (int i = 0; i < philosophers; i++)
    {
        init_sem(i, 1);
    }
    
    

    for (size_t process = 0; process < philosophers; process++)
    {
        switch (fork())
        {
        case -1:
            perror("Erzeugung fehlgeschlagen");
            exit(1);

        case 0:
            // Kindprozess
            printf("PE%ld - Philosoph %ld ist erschienen.\t(PID: %d)\n", process, process, getpid());
            philosopher(process);
            exit(0);

        default:
            // Vaterprozess
            break;
        }
    }
}

void philosopher(size_t process)
{
    int gabeln[2];
    gabeln[0] = process;
    
    if ((process + 1) < 5)
    {
        gabeln[1] = process + 1;
    }
    else
    {
        gabeln[1] = 0;
    }

    for (size_t i = 0; i < turn; i++)
    {
        denken(process);
        essen(process, gabeln[0], gabeln[1]);
    }
}

void denken(size_t process)
{
    printf("DS%ld - Philosoph %ld beginnt mit dem denken.\n", process, process);
    sleep((rand()%4) + 1);                                        // Zufallszahlen von 1 bis 4
    printf("DE%ld - Philosoph %ld beendet das denken.\n", process, process);
}

void essen(size_t process, int gabel_1, int gabel_2)
{
    printf("EW%ld (G1%d G2%d) - Philosoph %ld möchte gerne essen.\n", process, gabel_1, gabel_2, process);
    P(gabel_1, gabel_2);
    printf("ES%ld (G1%d G2%d) - Philosoph %ld beginnt mit dem essen.\n", process, gabel_1, gabel_2, process);
    sleep((rand()%4) + 1);                                        // Zufallszahlen von 1 bis 4
    printf("EE%ld (G1%d G2%d) - Philosoph %ld beendet das essen.\n", process, gabel_1, gabel_2, process);
    V(gabel_1, gabel_2);
}

void init_sem(int sem_num, int sem_init)
{
    if (semctl(sem_id, sem_num, SETVAL, sem_init) < 0)
    {
        perror("Fehler bei semctl");
        exit(1);
    }
}

void P(int sem_num_1, int sem_num_2)
{
    struct sembuf semaphore[2];

    semaphore[0].sem_num = sem_num_1;
    semaphore[0].sem_op = -1;
    semaphore[0].sem_flg = ~(IPC_NOWAIT|SEM_UNDO);

    semaphore[1].sem_num = sem_num_2;
    semaphore[1].sem_op = -1;
    semaphore[1].sem_flg = ~(IPC_NOWAIT|SEM_UNDO);

    if (semop(sem_id, &semaphore[0], 2))
    {
        perror("Fehler bei semop P()");
        exit(1);
    }
}

void V(int sem_num_1, int sem_num_2)
{
    struct sembuf semaphore[2];

    semaphore[0].sem_num = sem_num_1;
    semaphore[0].sem_op = 1;
    semaphore[0].sem_flg = ~(IPC_NOWAIT|SEM_UNDO);

    semaphore[1].sem_num = sem_num_2;
    semaphore[1].sem_op = 1;
    semaphore[1].sem_flg = ~(IPC_NOWAIT|SEM_UNDO);

    if (semop(sem_id, &semaphore[0], 2))
    {
        perror("Fehler bei semop V()");
        exit(1);
    }
}