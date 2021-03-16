#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <signal.h>

/* On remarque que la fonction write s'exécute toujours avant printf */
int main(int argc, char* argv[]){
		char buf[BUFSIZ];
	printf("Mon PID est %d; ", getpid());
	snprintf(buf, BUFSIZ, "My PID is %d; ", getpid());
	write(STDOUT_FILENO, buf, strlen(buf));
	switch (fork()) {
		case -1:
			perror("fork");
			exit(EXIT_FAILURE);
		case 0:
			printf("Je suis le fils et mon PID est %d; ", getpid());
			snprintf(buf, BUFSIZ, "I am the child and my PID is %d; ", getpid());
			write(STDOUT_FILENO, buf, strlen(buf));
			break;
		default:
			printf("Je suis le père et mon PID est %d; ", getpid());
			snprintf(buf, BUFSIZ, "I am the parent and my PID is %d; ", getpid());
			write(STDOUT_FILENO, buf, strlen(buf));
	}
	return 0;
}
