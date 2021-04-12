#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <x86intrin.h>

#define N 1e9

int size = N;
int* TAB;

void acces_seq(int n){
	int i;
	for(i = 0; i < n; i++){
		(TAB[i])++;
	}
}

void acces_alea(int n){
	int i, index;
	for(i = 0; i < n; i++){
		index = rand() % size;
		(TAB[index])++;
	}
}

void print_timing(int n, int (*f_to_time)(int)){
	unsigned int begin, end;
	float mesure;
	begin = clock();
	f_to_time(n);
	end = clock();
	mesure = (end - begin) / (float)CLOCKS_PER_SEC;
	printf("n=%d : %.10f sec\n", n, mesure);
}

int main(int argc, const char *argv[]){
	unsigned int begin, end;
	int n, i;
	TAB = (int*)malloc(sizeof(int)*size);

	n = atoi(argv[1]);
	srand(time(NULL));
	for(i = 0; i < 10; i++){
		begin = clock();
		acces_alea(n);
		end = clock();
		printf("%f s\n", (end - begin) / (float)CLOCKS_PER_SEC);
	}
	free(TAB);
	return 0;
}
