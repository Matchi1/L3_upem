#ifndef __NODE__
#define __NODE__

typedef struct node{
	char ch;
	struct node* g;
	struct node* d;
}Node, *Tree;

Node* make_node(char ch);

void free_tree(Tree tree);

void display_tree(Tree tree);

#endif
