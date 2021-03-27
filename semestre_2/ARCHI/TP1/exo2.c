#include <stdio.h>

int main(void){
	int tab[] = {1000, 1000000, 100000000};
	int i, j, k = 1000;

	for(j = 0; j < 3; j++){
		double result = 0, result1 = 0;
		k = tab[j];
		for(i = 1; i < k; i++){
			result += 1./ i;
		}

		for(i = k; i > 0; i--){
			result1 += 1./ i;
		}
		printf("%0.20f , %0.20f\n", result, result1);
	}

	return 0;
}
