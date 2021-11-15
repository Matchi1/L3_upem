#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

void try(char *name, int ret_value){
	if(ret_value == -1){
		perror(name);
		exit(EXIT_FAILURE);
	}
}

int main(void){
	int p, i;
	char buff[2];

	buff[1] = '\n';
	switch(fork()){
		case -1:
			try("fork", -1);
		case 0:
			for(i = 'A'; i <= 'Z'; i++){
				buff[0] = i;
				try("write", write(STDOUT_FILENO, buff, 2));
			}
			break;
		default:
			for(i = 'a'; i <= 'z'; i++){
				buff[0] = i;
				try("write", write(STDOUT_FILENO, buff, 2));
			}
			try("wait", wait(NULL));
			try("write", write(STDOUT_FILENO, "fin\n", 4));
	}
	return 0;
}
