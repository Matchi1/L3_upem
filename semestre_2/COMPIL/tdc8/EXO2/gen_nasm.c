#include <stdio.h>
#include <stdlib.h>
#include "gen_nasm.h"

#define FILE_NAME "gen_nasm.asm"
#define MAX_GLOBAL 64
#define MAX_LOCAL 64

int size_global = 0, size_local = 0;
int arr_global[MAX_GLOBAL];
int arr_local[MAX_LOCAL];

void data_section(){
	FILE* in = fopen(FILE_NAME, "w");
	fprintf(in, ".section data\n");
	fclose(in);
}

void add_global(int value){
	arr_global[size_global] = value;
	size_global++;
}

void add_local(int value){
	arr_local[size_local] = value;
	size_local++;
}

void global(){
	int i;

	FILE* in = fopen(FILE_NAME, "a");
	fprintf(in, "\ntable dq");
	for(i = 0; i < size_global - 1; i++){
		fprintf(in, " %d,", arr_global[i]);
	}
	fprintf(in, " %d\n", arr_global[i]);
	fclose(in);
}

void local(){
	int i;
	FILE* in = fopen(FILE_NAME, "a");
	fprintf(in, "\tpush rbp\n");
	fprintf(in, "\tmov rbp, rsp\n");
	for(i = 0; i < size_local; i++){
		fprintf(in, "\tpush %d\n", arr_local[i]);
	}
	fprintf(in, "\tpop rbp\n");
	fclose(in);
}

