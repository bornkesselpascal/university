// ----------------------------------------------------------------
// A goody
// ----------------------------------------------------------------
// Dump the list as input for the graphviz tool
// The filename of the file created is passed as second argument
// This shows writing to files with functions form the C standard library
// See http://www.graphviz.org/doc/info for details about the tool graphviz
//

#include <stdio.h>
#include <stdbool.h>

#include "singleLinkedIntList_type.h"
#include "dumpListForDot.h"

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
  fprintf(out,"\tnode [shape = record];\n");

  // Define a counter for naming the nodes
  int n=0;

  // Dump the nodes in graphviz syntax
  while ( node != NULL ) {
    // print the node definition
    fprintf(out,"\tnode%d [ label = \"<a> %d | <p> %p\"];\n",
        n, node->data, node->next);
    // print the edge definition
    if (node -> next !=NULL) {
      fprintf(out,"\t\"node%d\":p:s -> \"node%d\":a:n;\n", n, n+1);
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
