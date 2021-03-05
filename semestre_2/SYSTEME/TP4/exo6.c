#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <signal.h>

/* On remarque que la fonction write s'exécute toujours avant printf */
int main(int argc, char* argv[]){
	char str_pid[32] = "My Pid is :";
	char str_pid_child[32] = "I am the child :";
	char str_pid_parent[32] = "I am the parent :";

	sprintf(str_pid + 11, "%d", getpid());
	printf("Mon PID : %d", getpid());
	write(STDIN_FILENO, str_pid, 32);
	switch(fork()){
		case -1:
			perror("fork");
			exit(EXIT_FAILURE);
		case 0:
			sprintf(str_pid_child + 16, "%d", getpid());
			printf("je suis le fils : %d", getpid());
			write(STDIN_FILENO, str_pid_child, 32);
			break;
		default:
			sprintf(str_pid_parent + 17, "%d", getpid());
			printf("je suis le père : %d", getpid());
			write(STDIN_FILENO, str_pid_parent, 32);
	}
	puts("");
	return 0;
}
