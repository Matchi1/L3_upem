#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <x86intrin.h>

int main(int argc, const char *argv[]){
	unsigned int i, sum, handle = 0;
	int len = atoi(argv[1]);
	u_int64_t begin, end;

	begin = __rdtscp(&handle);
	for(i = 0; i < len; i++){
		sum += i * i;
	}
	end = __rdtscp(&handle);
	printf("%lu ticks\n", (end - begin));
	printf("TSC_AUX was %x\n", sum);
	return 0;
}
