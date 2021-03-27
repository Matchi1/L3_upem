#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>

void f(int n){
	printf("On ignore le SIGINT signal\n");
}

int main(void){
	if (signal(SIGINT, f) == SIG_ERR){
		perror("signal");
		exit(EXIT_FAILURE);
	}
	while(1) pause();
	return 0;
}
