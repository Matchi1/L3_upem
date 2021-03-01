#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

#define BUFFER_SIZE 10

void try(char* sysCall, int ret){
	if(ret < 0){
		perror(sysCall);
		exit(EXIT_FAILURE);
	}
}

int redirection(const char* filename){
	int fd;
	try("close", close(STDIN_FILENO));
	fd = open(filename, O_RDONLY);
	try("open", fd);
	return fd;
}

int main(int argc, const char *argv[]){
	char buf[BUFFER_SIZE];
	if(argc < 2){
		printf("Usage: %s <filename>\n", argv[0]);
		exit(EXIT_FAILURE);
	}
	redirection(argv[1]);
	scanf("%s", buf);
	printf("j'ai lu %s", buf);
	return 0;
}
