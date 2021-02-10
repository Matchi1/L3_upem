#ifndef __NODE__
#define __NODE__

typedef struct {
	char op[5];
	int val;
}Data;

typedef struct node{
	Data dt;
	struct node* g;
	struct node* d;
}Node, *Tree;

Node* make_node();

void free_tree(Tree tree);

void display_tree(Tree tree);

#endif
