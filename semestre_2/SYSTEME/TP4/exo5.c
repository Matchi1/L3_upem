#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <signal.h>

static void handler(int signo){
	printf("child died\n");
}

int main(int argc, char* argv[]){
	int status;
	signal(SIGCHLD, handler);
	switch(fork()){
		case -1:
			perror("fork");
			exit(EXIT_FAILURE);
		case 0:
			printf("child\n"); break;
		default:
			wait(&status);
			printf("parent\n");
	}
	return 0;
}
