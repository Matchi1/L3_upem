#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void try(char* sysCall, int retVal){
	if(retVal == -1){
		perror(sysCall);
		exit(EXIT_FAILURE);
	}
}

int main(int argc, char *argv[]){
	int fd[2];
	try("pipe", pipe(fd));
	switch(fork()){
		case -1:
			try("fork", -1);
		case 0:
			try("dup2", dup2(fd[1], 1));		/* créer un alias fd[1] et met le dans 1 */
			try("close", close(fd[0]));
			try("close", close(fd[1]));
			try("execlp", execlp(argv[1], argv[1], NULL));
			break;
		default:
			try("dup2", dup2(fd[0], 0));		/* créer un alias fd[0] et met le dans 0 */
			try("close", close(fd[0]));
			try("close", close(fd[1]));
			try("execlp", execlp(argv[2], argv[2], NULL));
	}
	return 0;
}
