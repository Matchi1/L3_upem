#include <stdio.h>
#include <stdlib.h>
#include "gen_nasm.h"

#define FILE_NAME "gen_nasm.asm"
#define MAX_GLOBAL 64
#define MAX_LOCAL 64

int size_global = 0, size_local = 0;
int arr_global[MAX_GLOBAL];
int arr_local[MAX_LOCAL];
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

