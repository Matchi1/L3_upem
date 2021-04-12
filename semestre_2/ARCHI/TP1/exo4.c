#include <stdio.h>

int main(void){
	int k[] = {20, 32, 100}, i, j, kIndex;
	float a, b, c;
	int trueValue, retValue = 0;
	/*
	for(i = 1; i < 10; i++){
		for(j = 1; j < 10; j++){
			a = i / 10.0;
			b = j / 10.0;
			c = (i + j) / 10.0;
			retValue = (a + b == c);
			printf("a: %0.10f, b: %0.10f, c: %0.10f\n", a, b, c);
			printf("a + b == c ? %d\n", retValue);
			if(retValue)
				trueValue++;
		}
	}
	printf("pourcentage de valeur vraies: %d\n", trueValue / 100);
	*/
	for(kIndex = 0; kIndex < 3; kIndex++){
		trueValue = 0;
		for(i = 1; i < k[kIndex]; i++){
			for(j = 1; j < k[kIndex]; j++){
				a = i / (float)k[kIndex];
				b = j / (float)k[kIndex];
				c = (i + j) / (float)k[kIndex];
				retValue = (a + b == c);
				if(retValue)
					trueValue++;
			}
		}
		printf("pourcentage de valeur vraies: %f\n", (trueValue * 100) / (float)(k[kIndex]*k[kIndex]));
	}
	return 0;
}
