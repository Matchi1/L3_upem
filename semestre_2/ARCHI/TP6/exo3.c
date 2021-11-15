#include <stdio.h>

int sum2 (int count){
	int s = 0, i;
	for(i = 0; i < count; i+=4){
		s+=i;
		s+=i+1;
		s+=i+2;
		s+=i+3;
	}
	return s;
}

int sum3 (int count){
	int s = 0, a, b, c, i;
	for(i = 0; i < count; i+=4){
		a=i+1;
		b=i+2;
		c=i+3;
		s+=i+a+b+c;
	}
	return s;
}

