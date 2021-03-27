#include <stdio.h>
#include <stdlib.h>


int main( int argc, char *argv[] ) {

  float a = 0.1, b = 0.2, c = 0.3;

  printf("%d\n",a + b == c );

  a = 1.1, b = 1.2, c = 2.3;

  printf("%d\n",a + b == c );

  return 0;
}
