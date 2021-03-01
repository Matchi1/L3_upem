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

void cat(int fd){
	int size;
	char buf[BUFFER_SIZE];
	while(1){
		size = read(fd, buf, BUFFER_SIZE);
		try("read", size);
		try("write", write(STDOUT_FILENO, buf, size));
		if(size < BUFFER_SIZE)
			return;
	}
}

int main(int argc, const char *argv[]){
	int fd, i;
	if(argc < 2){
		printf("Usage: %s <filename> <filename1> ...\n", argv[0]);
		exit(EXIT_FAILURE);
	}
	for(i = 1; i < argc; i++){
		fd = open(argv[i], O_RDONLY);
		try("open", fd);
		cat(fd);
		try("close", close(fd));
	}
	return 0;
}
