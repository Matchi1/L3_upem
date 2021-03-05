#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

void mrun(char *argv[]){
	int status;
	switch(fork()){
		case -1: 
			perror("fork"); 
			exit(EXIT_FAILURE);
		case 0: 
			execvp(argv[0], argv); 
			perror("execvp");
			exit(EXIT_FAILURE);
		default: 
			wait(&status);
			printf("%s est terminé\n", argv[0]); break;
	}
}

int main(int argc, char *argv[]){
	char name_buffer[32] = "RUN_", *var;
	int i;

	for(i = 0; ; i++){
		sprintf(name_buffer + 4 , "%d", i);
		if ((var = getenv(name_buffer)) != NULL)
		    printf("%s = %s\n", name_buffer, var);
		else
		    break;
		argv[0] = var;
		mrun(argv);
	}
	return 0;
}
