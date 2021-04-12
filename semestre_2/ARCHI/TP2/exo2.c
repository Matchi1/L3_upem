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

int main(int argc, const char *argv[]){
	unsigned int begin, end;
	int n, i;
	float total = 0., mesure;
	TAB = (int*)malloc(sizeof(int)*size);

	n = atoi(argv[1]);
	srand(time(NULL));
	for(i = 0; i < 10; i++){
		begin = clock();
		acces_alea(n);
		end = clock();
		mesure = (end - begin) / (float)CLOCKS_PER_SEC;
		total += mesure;
		printf("%f s\n", mesure);
	}
	printf("moyenne : %f s \n", total / 10);
	free(TAB);
	return 0;
}
