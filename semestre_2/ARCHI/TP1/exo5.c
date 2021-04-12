#include <stdio.h>

int main(void){
	int k[] = {10, 20, 100}, i, j, kIndex;
	double a, b, c;
	int trueValue, retValue = 0;
	int Cgreater = 0;
	float addf = 0.00000001;
	for(kIndex = 0; kIndex < 3; kIndex++){
		trueValue = 0;
		for(i = 1; i < k[kIndex]; i++){
			for(j = 1; j < k[kIndex]; j++){
				a = i / (float)k[kIndex];
				b = j / (float)k[kIndex];
				c = (i + j) / (float)k[kIndex];
				if(a + b < c)
					Cgreater = 1;
				else
					Cgreater = 0;
				if(a + b + addf < c + addf && Cgreater == 1)
					trueValue++;
				else if(a + b + addf > c + addf && Cgreater == 0)
					trueValue++;

			}
		}
		printf("pourcentage de valeur vraies: %f\n", (trueValue * 100) / (float)(k[kIndex]*k[kIndex]));
	}
	return 0;
}
