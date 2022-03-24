// Demo for unsorted single linked list of integers: functional version
// Show recursion via additional print statements
// NOTE:
// selection of iterative or recursive version is solely made by linking
// the appropriate object files
//

#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

#include "singleLinkedIntList_functional.h"
#include "dumpListForDot.h"

// Activate debug output
bool debug = false;

void nspace(int n){
  while (n > 0){
    printf(" ");
    n--;
  }
}

// Insert data at the end of the list
// Recursive version with debug statements
node_t* list_insert_end_dbg(node_t* node, int data, int offset) {
  if (debug){
    nspace(offset);
    printf("Enter list_insert_end_dbg: node == %p\n", node);
  }

  node_t *newnode;
  // Is the list empty
  if (node == NULL) {
    newnode = list_create_node(data);
    if (debug){
      nspace(offset);
      printf("Leave list_insert_end_dbg: returning address of new node at %p\n", newnode);
    }
    return newnode;
  } else {
    // Recursive call
    if (debug){
      nspace(offset);
      printf("Recursion with node -> next == %p\n", node->next);
    }

    node -> next = list_insert_end_dbg(node->next, data, offset + 4);

    if (debug){
      nspace(offset);
      printf("Link assignment: node -> next = %p\n", node->next);
      nspace(offset);
      printf("Leave list_insert_end_dbg: returning address %p\n", node);
    }
    return node;
  }
}

// ----------------------------------------------------------------
// MAIN
// ----------------------------------------------------------------

int main () {
  node_t* mylist=NULL;
  //int value;

  // ---------------------------------------
  // Demo: demonstrated recursion in list_insert_end_dbg
  printf("\nDemo for recursion in list_insert_end_dbg\n");
  mylist = list_insert_end_dbg(mylist, 10, 0);
  mylist = list_insert_end_dbg(mylist, 11, 0);
  mylist = list_insert_end_dbg(mylist, 12, 0);

  printf("\nList generated so far\n");
  list_dump(mylist);
  printf("\n");

  debug = true;
  mylist = list_insert_end_dbg(mylist, 13, 0);
  debug = false;

  // Free the list; assignment sets anchor to NULL
  mylist = list_free(mylist);

  // ---------------------------------------
  return EXIT_SUCCESS;
}
