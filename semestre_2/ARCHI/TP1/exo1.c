#include <stdio.h>

int main(void){
	int i = 3, j = 4;
	float a = i / 10.0;
	float b = j / 10.0;
	float c = (i + j) / 10.0;

	printf("%0.10f == %0.10f\n", (a + b), c);
	return 0;
}