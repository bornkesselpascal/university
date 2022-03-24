#include<stdio.h>
#include<stdlib.h>

// -----------------------------------------------------------------------
// Type definition for list elements
// -----------------------------------------------------------------------

typedef struct node {
  int data;
  struct node* next;
} node_t;

// -----------------------------------------------------------------------
// Forward declarations
// -----------------------------------------------------------------------
node_t* list_create_node(int data);
void list_print_data_from_front(node_t* node);
node_t* list_insert_end(node_t* node, int data);
node_t* list_free(node_t* node);
int list_len(node_t* node);
void dump_list(node_t *node);

// -----------------------------------------------------------------------
// The function to be demonstrated
// -----------------------------------------------------------------------

// Interface: recursive + functional
// Criticism: multiple return statements
//
// Remove tail node of list
node_t* list_remove_tail(node_t* node){
  if (node == NULL) {
    return NULL;
  } else {
    if (node->next == NULL) {
      // Remove last node
      free(node);
      return NULL;
    } else {
      // Recursive call
      node->next = list_remove_tail(node->next);
      return node;
    }
  }
}

// -----------------------------------------------------------------------
// MAIN
// -----------------------------------------------------------------------

int main(){
  node_t *anchor;

  // Build list pointed to by anchor
  // anchor = NULL;
  // anchor = list_insert_end(anchor,10);
  // anchor = list_insert_end(anchor,20);
  // anchor = list_insert_end(anchor,30);
  // anchor = list_insert_end(anchor,40);

  // Alternative way to build the list the functional way
  anchor = list_insert_end(
      list_insert_end(
        list_insert_end(
          list_insert_end(NULL, 10), 20), 30), 40);

  dump_list(anchor);
  anchor = list_remove_tail(anchor);
  dump_list(anchor);
  anchor = list_remove_tail(anchor);
  dump_list(anchor);
  anchor = list_remove_tail(anchor);
  dump_list(anchor);
  anchor = list_remove_tail(anchor);
  dump_list(anchor);

  // Cleanup
  list_free(anchor);


  return EXIT_SUCCESS;
}

// -----------------------------------------------------------------------
// Functions for list manipulation
// -----------------------------------------------------------------------

// Create a new node and return its pointer
node_t* list_create_node(int data) {
  node_t* newnode;
  // Create a new node for data
  if ((newnode = malloc(sizeof(node_t))) == NULL) {
    fprintf(stderr,"list_create_node: Unable to create a new data node\n");
    // Here we bail out without any attempts for recovery
    // This is a very simplistic strategie
    exit(EXIT_FAILURE);
  } else {
    // Initialize node
    newnode -> data = data;
    newnode -> next = NULL;
    return  newnode;
  }
}

// Insert data at the end of the list
// Recursive version
node_t* list_insert_end(node_t* node, int data) {
  // Is the list empty
  if (node == NULL) {
    return list_create_node(data);
  } else {
    // Recursive call
    node -> next = list_insert_end(node->next, data);
    return node;
  }
}

// Free memory of all nodes in a list
// Recursive version
// Note:
// The interface allows for writing e.g.
// mylist = list_free(mylist);
// which assigns a NULL to the pointer mylist right away.
// This helps in avoiding dangling pointers.
//
node_t* list_free(node_t* node) {
  if ( node != NULL) {
    // Recursive call
    list_free(node->next);
    // Free memory of current node
    free(node);
  }
  return NULL;
}

// Print the data of the list from head to tail
void list_print_data_from_front(node_t * node) {
  // dump list at entry
  // list_dump_as_graph(node,"demo1.dot");
  if (node == NULL) {
    printf("\n");
    return;
  } else {
    printf("%3d ", node -> data);
    list_print_data_from_front(node->next);
    return;
  }
}

int list_len(node_t* node){
  if (node == NULL) {
    return 0;
  } else {
    return 1+ list_len(node->next);
  }
}

void dump_list(node_t *node){
  printf("len %2d: ",  list_len(node));
  list_print_data_from_front(node);
}

