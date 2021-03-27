#include <stdio.h>
#include <stdlib.h>


int main( int argc, char *argv[] ) {
  int a = -100, b = -200;
  int c = a + b;
  
  int* p = &c;

  printf("%d \n", *p);

  return 0;
}
