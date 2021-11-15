#include <stdio.h>
#include <stdlib.h>

#define N 1000

int *A, *B, *C;

void boucle1(){
	int i;
	for(i = 0; i < N; i++){
		A[i]=A[i+1];
	}
}

void boucle2(){
	int i;
	for(i = 0; i < N; i++){
		A[i]=B[i];
	}
}

void boucle3(){
	int i;
	for(i = 0; i < N-1; i++){
		A[i]=B[i+1];
	}
}

void boucle4(){
	int i;
	for(i = 1; i < N-4; i++){
		A[i]=B[i];
		A[i+1]=B[i+1];
	}
}

void boucle5(){
	int i;
	for(i = 1; i < N-4; i+=2){
		A[i]=B[i];
		A[i+2]=B[i+2];
	}
}

void boucle6(){
	int i;
	for(i = 1; i < N-4; i++){
		A[i]=B[i];
		A[i+4]=B[i+4];
	}
}

void boucle7(){
	int i;
	for(i = 1; i < N-4; i++){
		A[i]=B[i];
		B[i]=C[i];
	}
}

void boucle8(){
	int i;
	for(i = 1; i < N-4; i++){
		A[i]=B[i+1];
		B[i]=C[i];
	}
}

void boucle9(){
	int i;
	for(i = 1; i < N-4; i++){
		A[i]=B[i-1];
		B[i]=C[i];
	}
}

void boucle10(){
	int i;
	for(i = 4; i < N-4; i++){
		A[i]=B[i+4];
		B[i]=C[i];
	}
}

int main(void){
	A = (int*) calloc(sizeof(int), 100);
	B = (int*) calloc(sizeof(int), 100);
	C = (int*) calloc(sizeof(int), 100);
	return 0;
}
