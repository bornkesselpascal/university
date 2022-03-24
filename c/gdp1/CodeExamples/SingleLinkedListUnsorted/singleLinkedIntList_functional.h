// Header file for single linked int lists
// Interface uses functional style.
// The functions return pointers to the resulting lists.
// 

#ifndef _SINGLE_LINKED_LIST_FUNCTIONAL_H
#define _SINGLE_LINKED_LIST_FUNCTIONAL_H

#include <stdbool.h>
#include "singleLinkedIntList_type.h"

extern node_t* list_create_node(int data);

extern node_t* list_insert_front(node_t* anchor, int data);
extern node_t* list_insert_end(node_t* anchor, int data);

extern void list_dump(node_t *anchor);
extern node_t* list_free(node_t* anchor);
extern bool list_contains(node_t* anchor, int data);

extern int list_get_head(node_t* anchor);
extern int list_get_tail(node_t* anchor);

extern node_t* list_remove_head(node_t* anchor);
extern node_t* list_remove_tail(node_t* anchor);

extern node_t* list_delete_all(node_t* anchor, int data);
extern node_t* list_delete_first(node_t* anchor, int data);

#endif
