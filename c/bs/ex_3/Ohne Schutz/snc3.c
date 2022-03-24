#include <stdio.h>
#include <pthread.h>

const size_t MAX_CNT = 10000000;
int counter;

pthread_mutex_t dyn_mutex;

void* increment(void* args) {
      
    for (size_t i = 0; i <= MAX_CNT; i++) {
        pthread_mutex_lock(&dyn_mutex);
        counter ++;
        pthread_mutex_unlock(&dyn_mutex);
    }

    return NULL;
}

void* decrement(void* args) {
    for (size_t j = 0; j <= MAX_CNT; j++) {
        pthread_mutex_lock(&dyn_mutex);
        counter --;
        pthread_mutex_unlock(&dyn_mutex);
    }

    return NULL;
} 


int main() {
    
    pthread_mutex_init(&dyn_mutex, NULL);

    pthread_t threads[2];

    pthread_create(&(threads[0]), NULL, &increment, NULL);
    pthread_create(&(threads[1]), NULL, &decrement, NULL);

    pthread_join(threads[0], NULL);
    pthread_join(threads[1], NULL);
 
    pthread_mutex_destroy(&dyn_mutex);
   
    printf("Counter: %d \n", counter);   
}
