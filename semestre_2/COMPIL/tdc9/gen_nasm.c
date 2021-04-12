#include <stdio.h>
#include <stdlib.h>
#include "gen_nasm.h"

#define FILE_NAME "gen_nasm.asm"
#define MAX_GLOBAL 64
#define MAX_LOCAL 64

int size_global = 0, size_local = 0;
int arr_global[MAX_GLOBAL];
int arr_local[MAX_LOCAL];
int label = 0;
FILE *in;

void open_gen(){
	in = fopen(FILE_NAME, "w");
}

void close_gen(){
	fclose(in);
}

void create_section(char *section){
	fprintf(in, "section .%s\n", section);
}

void create_global(int STsize){
	int i;
	fprintf(in, "table dq");
	for(i = 0; i < STsize - 1; i++)
		fprintf(in, " 0,");
	fprintf(in, " 0\n");
}

int newlabel(){
	return label++;
}

void create_if(Node* node){
	int label1 = newlabel();
	int label2 = newlabel();
	fprintf(in, "if:\n");
	fprintf(in, "\tcmp %s, %s\n", FIRSTCHILD(node)->u.identifier, SECONDCHILD(node)->u.identifier);
	switch(node->u.op){
		case 3:
			fprintf(in, "\tjg %d\n", label1);
			break;
		default:
			break;
	}
	fprintf(in, "\tjmp %d\n\n", label2);
	fprintf(in, "%d:", label1);
	fprintf(in, "%d:", label2);
}
