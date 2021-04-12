#ifndef __GEN_NASM__
#define __GEN_NASM__

#include "abstract-tree.h"

void open_gen();
void close_gen();
void create_section(char *section);
void create_global(int STsize);
void create_if(Node* node);

#endif
