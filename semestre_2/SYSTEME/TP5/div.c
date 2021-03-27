#include <stdio.h>

int main() {
	setbuf(stdout, NULL);
	int a, b;
	while (scanf("%d%d", &a, &b) == 2) {
		if(b == 0)
			printf("Division par zéro\n");
		else
			printf("result: %d\n", a / b);
	}
}
