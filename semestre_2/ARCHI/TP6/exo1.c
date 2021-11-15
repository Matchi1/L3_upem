#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void print_timing(int n, int (*f_to_time)(int)){
	unsigned int begin, end;
	float mesure;
	begin = clock();
	f_to_time(n);
	end = clock();
	mesure = (end - begin) / (float)CLOCKS_PER_SEC;
	printf("n=%d : %.10f sec\n", n, mesure);
}

int sum0(int n){
	int i,s = 0;
	for(i = 0; i < n; i++)
		s += i;
	return s;
}
 
/*
int sum0_vect(int n){
	k = n / 4;
	s = 0,0,0,0
	u = 0,1,2,3
	for(i = 0; i < k; i++){
		s += u
		u += 4,4,4,4
	}
	r = sum_comp(s)
	j = 4 * i
	for(i = 0; i < n; i++)
		r += i
	renvoyer r
}
*/

int sum1(int n){
	int i,s = 0;
	for(i = 0; i < n; i++)
		if (i < 10) s += i;
	return s;
}

/*
int sum1_vect(int n){
	k = n / 4
	s = 0,0,0,0
	u = 0,1,2,3
	t = 10,10,10,10
	for(j = 0; j < k; j++){
		u = i < t
		v = i AND u
		s += v
		i += 4,4,4,4
	}
	return sum_comp(s);
}
*/

int main(int argc, const char* argv[]){
	int n = 400;
	print_timing(n, sum0);
	return 0;
}
