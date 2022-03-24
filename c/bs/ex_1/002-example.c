#include <stdio.h>
#include <pthread.h>

/* Thread-Funktion */
void *example_fct(void *args){
  /* Die Übergabe wird zurück auf einen int-Pointer gecastet*/
  int *inParam = (int  *)args;
  
  /* Der Inhalt des Pointers wird ausgegeben */
  printf("Infos von Main: %d\n", *inParam);

  return (void *)101010;
}

int main(){
  /* Lege ein Thread-Handle, einen Übergabe- und einen Rückgabeparameter an */
  pthread_t thread;
  int threadParam = 42;
  int threadRetParam = -1;

  /* Starte einen Thread mit der auszuführenden Funktion example_fct.
     Zudem wir ein Parameter übrgeben.
     Konfigurations-Parameter werden nicht gesetzt, daher NULL. */
  pthread_create(&thread, NULL, &example_fct, &threadParam);

  /* Warte auf Beendigung des Threads */
  pthread_join(thread, (void **)(&threadRetParam));
  
  /* Inhalt des Rückgabeparameters ausgeben */
  printf("Rueckgabe von Thread: %d\n", threadRetParam);

  return 0;
}
