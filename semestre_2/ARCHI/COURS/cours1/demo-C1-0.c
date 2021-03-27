#include <stdio.h>
#include <stdlib.h>

int main( int argc, char *argv[] ) {
	int a = 5;
  	int *p = &a;
  	
  	printf("%d, %u, %p \n", a, a, a);
  	printf("%d, %u, %p \n", p, p, p);
  	return 0;
}
