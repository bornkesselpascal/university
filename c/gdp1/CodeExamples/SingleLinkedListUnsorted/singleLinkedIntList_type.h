// Type definition for single linked int lists
// 

#ifndef _SINGLE_LINKED_LIST_TYPE_H
#define _SINGLE_LINKED_LIST_TYPE_H


typedef struct node {
  int data;               // Payload; integer data
  struct node* next;      // Pointer to next node
} node_t;

#endif
