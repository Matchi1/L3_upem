#include <stdio.h>
 
int add(int arg1, int arg2, int arg3, int arg4, int arg5, int arg6){
	return arg1 + arg2 + arg3 + arg4 + arg5 + arg6;
}

int main(int argc, char * argv[]){
	int res;
	res = add(1, 2, 3, 4, 5, 6);
	return 0;
}
