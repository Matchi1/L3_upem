#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

void usage(char *prog){
	printf("%s <message> <délai>\n", prog);
}

void try(char* fctName, int retValue){
	if(retValue == -1){
		perror(fctName);
		exit(EXIT_FAILURE);
	}
}

int main(int argc, const char *argv[]){
	int inter = atoi(argv[2]);
	int length = strlen(argv[1]);
	while(1){
		try("write", write(STDOUT_FILENO, argv[1], length));
		usleep(inter);
	}
	return 0;
}
