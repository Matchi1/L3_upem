#include <stdio.h>
int main() {
	int i, j=0, k=0, l=0, res=0;
	for (i=1; i<10; i++){
		j+=i*i*i*i;
		k+=j*j*j*j;
		l+=j*j*k*k;
		res+=j/k;
		res+=l;
	}
	printf("%d\n",res); return 0;
}
