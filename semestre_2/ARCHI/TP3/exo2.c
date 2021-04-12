#include <stdio.h>
#include <time.h>

#define N 1e7

int parcours(int n, int pas){
	int i, index, tab[n];
	index = 0;
	for(i = 0; i < N; i++){
		tab[index] = 0;
		index += pas;
		if(index >= n)
			index %= n;
	}
}

int puissance2(int n){
	int i, result = 1;
	for(i = 0; i < n; i++){
		result *= 2;
	}
	return result;
}

int main(int argc, char *argv[]){
	int puis2, expo[] = {10, 16, 17, 18, 19, 20, 21, 22, 30};
	int n, i;
	float mesure;
	unsigned int begin, end;

	for(i = 0; i < 9; i++){
		n = puissance2(expo[i]);
		for(puis2 = 1; puis2 < 129; puis2 *= 2){
			begin = clock();
			parcours(n, puis2);
			end = clock();
			mesure = (end - begin) / (float)CLOCKS_PER_SEC;
			printf("n = 2^%d, %d : %f s\n", expo[i], puis2, mesure);
		}
	}
	return 0;
}
