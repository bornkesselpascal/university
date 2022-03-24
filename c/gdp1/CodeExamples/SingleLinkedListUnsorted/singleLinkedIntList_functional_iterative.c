// Implementation for unsorted single linked list of integers: iterative version
// 
// NOTE:
// We use a very simple error handling method.
// If anything is wrong, we bail out with an exit()

#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

#include "singleLinkedIntList_functional.h"

// Create a new node and return its pointer
node_t* list_create_node(int data) {
  node_t* newnode;
  // Create a new node for data
  if ((newnode = malloc(sizeof(node_t))) == NULL) { 
    fprintf(stderr,"list_insert: Unable to create a new data node\n");
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
  newnode->next = anchor;
  // Return newnode
  return newnode;
}

// Insert data at the end of the list
//
node_t* list_insert_end(node_t* anchor, int data) {
  // Is the list empty
  if (anchor == NULL) {
    return list_create_node(data);
  }
  // List is not empty: go to last node
  node_t* pnode = anchor;
  while (pnode->next != NULL) {
    pnode = pnode -> next;
  }
  // We are at the last node
  pnode -> next = list_create_node(data);
  // Return the anchor to the list
  return anchor;
}	

// Dump all nodes of a list inclusive information about addresses
void list_dump(node_t *node) {
  while ( node != NULL ) {
    printf("Node at %p: data = %d next = %p\n",
        node, node->data, node -> next);
    node = node -> next;
  }
  return;
}

// Free memory of all nodes in a list
// Note:
// The interface allows for writing e.g.
// mylist = list_free(mylist);
// which assigns a NULL to the pointer mylist right away.
// This helps in avoidng dangling pointers.
//

node_t* list_free(node_t* node) {
  node_t* temp;
  while ( node != NULL ) {
    // Remember pointer for later call of free()
    temp = node;
    // Move on to next node
    node = node->next;
    // Free memory
    free(temp);
  }
  return NULL;
}

// Check if there is a node in list with specified data
bool list_contains(node_t* node, int data) {
  bool res = false;
  while(node != NULL) {
    if (node->data == data) {
      res = true;
      break;
    }
    node = node->next;
  }
  return res;
}

// Get data of head node in list
// Bail out if list is empty
int list_get_head(node_t* node){
  if (node == NULL) {
    fprintf(stderr,"list_get_head: empty list\n");
    // Here we bail out without any attempts for recovery
    // This is a very simplistic strategie
    exit(EXIT_FAILURE);
  } else {
    return node->data;
  }
}

// Get data of tail node in list
// Bail out if list is empty
int list_get_tail(node_t* node){
  if (node == NULL) {
    fprintf(stderr,"list_get_tail: empty list\n");
    // Here we bail out without any attempts for recovery
    // This is a very simplistic strategie
    exit(EXIT_FAILURE);
  } else {
    while (node->next != NULL) {
      node = node->next;
    }
    // Return data of last node
    return node->data;
  }
}

// Remove head node of list
node_t* list_remove_head(node_t* node){
  if (node == NULL) {
    return NULL;
  } else {
    // Remember pointer to next node
    node_t* temp = node->next;
    // Remove head node
    free(node);
    return temp;
  }
}

// Remove tail node of list
// A first version, that has some defects concerning the style
node_t* list_remove_tail_V1(node_t* anchor){
  if (anchor == NULL) {
    return NULL;
  } else {
    node_t* last = NULL;   // Last node before tail node

    // Go to tail node in list
    node_t* node = anchor;	// Current node in iteration
    while (node->next != NULL) {
      last = node;
      // Advance iteration
      node = node -> next;
    }

    // node points to tail node in list
    // Free that node
    free(node);

    if (last == NULL) {
      // node was the only node in the list
      return NULL;
    } else {
      // Terminate list
      last->next = NULL;
      return anchor;
    }
  }
}

// Remove tail node of list
// A better version
node_t* list_remove_tail(node_t* node){
  node_t *result = node; // init result
  if (node != NULL) {
    node_t* last = NULL;   // Last node before tail node

    // Go to tail node in list
    while (node->next != NULL) {
      last = node;
      // Advance iteration
      node = node -> next;
    }

    // node points to tail node in list
    // Free that node
    free(node);

    if (last == NULL) {
      // node was the only node in the list
      result = NULL;
    } else {
      // List had at least two elements
      // Terminate list
      last->next = NULL;
    }
  }
  return result;
}

//  Delete all occurrences of a node containing specified data
node_t* list_delete_all(node_t* anchor, int data) {
  // Init result and pointer to last node in result
  node_t* result = NULL; // Anchor to result
  node_t* last = NULL;   // Last known node of result

  // Init traversal
  node_t* cur_node = anchor;	// Current node in iteration
  while (cur_node != NULL) {
    // Remember current node in temp
    node_t* temp = cur_node;
    // Advance iteration
    cur_node = cur_node -> next;
    // Isolate the temporary node
    temp->next = NULL;	

    // What shall we do with the temporary node?
    if (temp -> data == data) {
      // Data matches -> remove that node
      free(temp);
    } else {
      // Data does not match -> keep that node
      // Is last still uninitialized?
      if (last == NULL) {
        // Init last and result
        last = result = temp;
      } else {
        // Add temp node after last
        last -> next = temp;
        last = temp;
      }
    }
  }
  return result;
}

// Delete first occurrence of a node containing specified data
node_t* list_delete_first(node_t* anchor, int data) {
  // The result pointer
  node_t* result = NULL;
  // Last known node of result
  node_t* last = NULL;
  // Init traversal
  node_t* cur_node = anchor;	// Current node in iteration
  while (cur_node != NULL) {
    if(cur_node->data == data) {
      break; // We found the first occurrence
    }
    last = cur_node;
    cur_node = cur_node -> next;
  }

  // Check situation after loop
  if (cur_node == NULL) {
    // cur_node == NULL && we left the loop
    // -> no node contained the data
    result = anchor;
  } else if (last != NULL) {
    // last != NULL && cur_node != NULL && we left the loop
    // We found the data and it did not occur in the first node
    last -> next = cur_node -> next;
    result = anchor;
    free(cur_node);
  } else {
    // last == NULL && cur_node != NULL && we left the loop
    // The data occured in the first node
    result = anchor -> next;
    free(anchor);
  }

  return result;
}
