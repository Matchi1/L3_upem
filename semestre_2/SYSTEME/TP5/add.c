#include <stdio.h>

int main() {
	setbuf(stdout, NULL);
	int a, b;
	while (scanf("%d %d", &a, &b) == 2) {
		printf("result: %d\n", a + b);
	}
}
