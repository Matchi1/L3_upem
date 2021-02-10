#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "Node.h"

Node* make_node(){
	Node* node;

	node = (Node*)malloc(sizeof(Node));
	if(NULL == node){
		perror("malloc");
		exit(EXIT_FAILURE);
	}
	return node;
}

void display_tree_aux(Tree tree, int height){
	int i;
	if(tree != NULL){
		for(i = 0; i < height; i++)
			printf("\t");
		if(strcmp(tree->dt.op, "NONE") == 0)
			printf("%d\n", tree->dt.val);
		else
			printf("%s\n", tree->dt.op);
		display_tree_aux(tree->g, height + 1);
		display_tree_aux(tree->d, height + 1);
	}
}

void display_tree(Tree tree){
	display_tree_aux(tree, 0);
}

void free_tree(Tree tree){
	if(tree != NULL){
		free_tree(tree->g);
		free_tree(tree->d);
		free(tree);
	}
}
