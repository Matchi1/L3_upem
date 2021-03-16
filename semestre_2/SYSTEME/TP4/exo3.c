#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

#define MAX_CHAR 256

void boucle(int length){
	int i, status, size, pid;
	char str[MAX_CHAR];

	for(i = 1; i <= length; i++){
		switch(fork()){
			case -1:
				perror("fork");
				exit(EXIT_FAILURE);
			case 0:
				size = sprintf(str, "je suis le numéro %d, mon PID est %d et mon père est %d\n", i, getpid(), getppid());
				write(STDOUT_FILENO, str, size);
				exit(i);
			default:
				break;
		}
	}
	for(i = 1; i <= length; i++){
		if (!WIFEXITED(status)) {
			fprintf(stderr, "Child with PID %d has not exited.\n", pid);
			exit(EXIT_FAILURE);
		}
		pid = wait(&status);
		size = sprintf(str, "le processus n°%d de PID %d vient de terminer\n", WEXITSTATUS(status), pid);
		write(STDOUT_FILENO, str, size);
	}
}

int main(int argc, char *argv[]){
	boucle(20);
	return 0;
}
