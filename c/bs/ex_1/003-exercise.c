#include <stdio.h>
#include <pthread.h>
#include <string.h>

struct student {
    char name[100];
    size_t r_lenght;
};


/* Thread-Funktion */
void *example_fct(void *args){
  /* Die Übergabe wird zurück auf einen int-Pointer gecastet*/
    
    struct student *stud = (struct student *)args;
    
    size_t lenght;

    lenght = strlen(stud->name);

    (*stud).r_lenght = lenght;

  return NULL;
}


int main(){
    /* Lege ein Thread-Handle an */
  pthread_t thread;

  struct student stud_example;

  strcpy(stud_example.name, "Pascal");      //strcpy -> normale Zuweisung von Strings nur bei Initialisierung

    /* Starte einen Thread mit der auszuführenden Funktion example_fct.
     Zudem wir ein Parameter übrgeben.
     Konfigurations-Parameter werden nicht gesetzt, daher NULL. */

  pthread_create(&thread, NULL, &example_fct, &stud_example);


    /* Warte auf Beendigung des Threads */

  pthread_join(thread, NULL);
  
    /* Inhalt der Struktur ausgeben */
  printf("Name: %s\n",stud_example.name);
  printf("Länge: %zu\n",stud_example.r_lenght);

  return 0;
}
