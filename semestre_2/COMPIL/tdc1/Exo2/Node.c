#include <stdio.h>
#include <stdlib.h>
#include "Node.h"

Node* make_node(char ch){
	Node* node;

	node = (Node*)malloc(sizeof(Node));
	if(NULL == node){
		perror("malloc");
		exit(EXIT_FAILURE);
	}
	node->ch= ch;
	return node;
}

void display_tree_aux(Tree tree, int height){
	int i;
	if(tree != NULL){
		for(i = 0; i < height; i++)
			printf("\t");
		if(tree->ch == 0)
			printf("NULL\n");
		else
			printf("%c\n", tree->ch);
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
