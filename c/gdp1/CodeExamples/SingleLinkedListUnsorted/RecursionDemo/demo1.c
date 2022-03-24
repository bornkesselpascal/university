// -----------------------------------------------------------------------
// A demo for recursive functions
// For simplicity we collected all code into a single file.
//
// Use the following command to visualize the file generated
//    dot -Txlib demo1.dot
// The dot utility traces changes on the file by using inotify

#include<stdio.h>
#include<stdlib.h>

// -----------------------------------------------------------------------
// Type definition for list elements
// -----------------------------------------------------------------------

typedef struct node {
  int data;               // Payload; integer data
  struct node* next;      // Pointer to next node
} node_t;

// -----------------------------------------------------------------------
// Forward declarations
// -----------------------------------------------------------------------
node_t* list_create_node(int data);
node_t* list_insert_front(node_t* anchor, int data);
node_t* list_free(node_t* node);
void list_dump_as_graph(node_t *node, char* filename);

// -----------------------------------------------------------------------
// The function we use for demonstrating a simple recursion over lists
// -----------------------------------------------------------------------

// Print the data of the list from head to tail
void list_print_data_from_front(node_t * node) {
  // dump list at entry
  // list_dump_as_graph(node,"demo1.dot");
  if (node == NULL) {
    printf("\n");
    return;
  } else {
    printf("%d ", node -> data);
    list_print_data_from_front(node->next);
    return;
  }
}

// -----------------------------------------------------------------------
// MAIN
// -----------------------------------------------------------------------

int main(){
  node_t * anchor=NULL;

  // Build the list
  anchor = list_insert_front(anchor,10);
  anchor = list_insert_front(anchor,20);
  anchor = list_insert_front(anchor,30);
  anchor = list_insert_front(anchor,40);
  anchor = list_insert_front(anchor,50);

  // Dump list to file for visualization by graphviz util 'dot'
  list_dump_as_graph(anchor,"demo1.dot");

  // Call the demo function
  // We will use the debugger to demonstrate the recursive calls
  list_print_data_from_front(anchor);

  // Cleanup
  anchor = list_free(anchor);

  return EXIT_SUCCESS;
}

// -----------------------------------------------------------------------
// Functions for list manipulation used in the demo
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

// Insert data at the front of the list
node_t* list_insert_front(node_t* anchor, int data) {
  node_t* newnode;
  // Create a new node for the data
  newnode = list_create_node(data);
  // Add new node before the anchor
  newnode->next = anchor;
  // Return newnode
  return newnode;
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

// -----------------------------------------------------------------------
// Auxiliary functions
// -----------------------------------------------------------------------

// A function that dumps a list into a file for further use with graphviz.
// Use xdot for viewing the file generated.
void list_dump_as_graph(node_t *node, char* filename) {
  // Define a file handle
  FILE* out;
  // Open the file for writing
  if ((out = fopen(filename,"w")) == NULL) {
    fprintf(stderr,"Unable to open file %s for writing\n", filename);
    return;
  }
  // Print preamble to file
  fprintf(out,"digraph G {\n");
  fprintf(out,"\tnodesep=.05;\n");
  fprintf(out,"\trankdir=LR;\n");
  fprintf(out,"\tnode [shape = record];\n");

  // Define a counter for naming the nodes
  int n=0;

  // Dump the nodes in graphviz syntax
  while ( node != NULL ) {
    // print the node definition
    fprintf(out,"\tnode%d [ label = \"<a> %p | { %d | <p> %p }\"];\n",
        n, node, node->data, node->next);
    // print the edge definition
    if (node -> next !=NULL) {
      fprintf(out,"\t\"node%d\":p:e -> \"node%d\":a:w;\n", n, n+1);
    }
    // increment node name and go the next node
    n++;
    node = node -> next;
  }

  // Print epilog to file
  fprintf(out,"}\n");
  // Close the file
  fclose(out);

  return;
}

