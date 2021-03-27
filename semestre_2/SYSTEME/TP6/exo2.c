#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>

void f(int n){
	printf("On ignore le SIGINT signal\n");
}

int main(void){
	struct sigaction sig;
	sig.sa_handler = f;
	sigemptyset(&sig.sa_mask);
	sig.sa_flags = 0;
	if(sigaction(SIGINT, &sig, NULL) == -1){
		perror("sigaction");
		exit(EXIT_FAILURE);
	}
	while(1) pause();
	return 0;
}
