// Implementation for unsorted single linked list of integers: recursive version
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

// Dump all nodes of a list inclusive information about addresses
// Recursive version
void list_dump(node_t *node) {
  if (node == NULL) {
    return;
  } else {
    printf("Node at %p: data = %d next = %p\n",
        node, node->data, node -> next);
    // Recursive call
    list_dump(node->next);
  }
  return;
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

// Check if there is a node in list with specified data
// Recursive version
bool list_contains(node_t* node, int data) {
  if (node == NULL) {
    return false;
  } else if (node->data == data) {
    return true;
  } else {
    // Recursive call
    return list_contains(node->next, data);
  }
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
    return node -> data;
  }
}

// Get data of tail node in list
// Bail out if list is empty
// Recursive version
int list_get_tail(node_t* node){
  if (node == NULL) {
    fprintf(stderr,"list_get_tail: empty list\n");
    // Here we bail out without any attempts for recovery
    // This is a very simplistic strategie
    exit(EXIT_FAILURE);
  } else {
    if (node->next == NULL){
      return node->data;
    } else {
      // Recursive call
      return list_get_tail(node->next);
    }
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
// Recursive version
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

// Delete all occurrences of a node containing specified data
// Recursive version
node_t* list_delete_all(node_t* node, int data) {
  if (node == NULL) {
    return NULL;
  } else {
    if (node->data == data) {
      // Recursive call
      node_t* temp = list_delete_all(node->next, data);
      // Data matches -> remove the node
      free(node);
      return temp;
    } else {
      // Recursive call
      node->next = list_delete_all(node->next, data);
      return node;
    }
  } 
}


// Delete first occurrence of a node containing specified data
// Recursive version
node_t* list_delete_first(node_t* node, int data) {
  if (node == NULL) {
    return NULL;
  } else {
    if (node->data == data) {
      // Remember pointer to next node
      node_t* temp = node->next;
      // Data matches -> remove the node
      free(node);
      return temp;
    } else {
      // Recursive call
      node->next = list_delete_first(node->next, data);
      return node;
    }
  } 
}
