#include <stdio.h>
#include <stdlib.h>


int main( int argc, char *argv[] ) {
  int a = -100, b = -200;
  unsigned int c = (unsigned int)a + (unsigned int)b;
  int* p = (int*) &c;

  printf("%d \n", *p);

  return 0;
}
