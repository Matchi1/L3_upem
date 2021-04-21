#include <stdio.h>
#include <stdlib.h>

#define SIZE 1000000000

int puissance2(int n){
	int result = 1, i;
	for(i = 0; i < n; i++)
		result *= 2;
	return result;
}

void acces_k(int n, int k, int v, int* tab){
	int i, j, index;
	for(i = 0; i < n; i++){
		index = 0;
		for(j = 0; j < k; j++){
			if(index >= SIZE)
				index %= SIZE;
			tab[index] = 'a';
			index += v;
		}
	}
}

int main(int argc, const char* argv[]){
	int N = puissance2(28);
	int n, k = 128, v = puissance2(20), i;
	int* tab = (int*)malloc(sizeof(int) * SIZE);
	unsigned int begin, end;
	float result;
	
	n = N / k;
	acces_k(n, k, v, tab);
	return 0;
}
