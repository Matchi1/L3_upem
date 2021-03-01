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

void cp(int fd_src, int fd_dest){
	int size;
	char buf[BUFFER_SIZE];
	while(1){
		size = read(fd_src, buf, BUFFER_SIZE);
		try("read", size);
		try("write", write(fd_dest, buf, size));
		if(size < BUFFER_SIZE)
			return;
	}
}

int main(int argc, const char *argv[]){
	int fd_src, fd_dest;
	if(argc < 2){
		printf("Usage: %s <filename> <filename1>\n", argv[0]);
		exit(EXIT_FAILURE);
	}
	fd_src = open(argv[1], O_RDONLY);
	fd_dest = open(argv[2], O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_ISUID);
	try("open", fd_src);
	try("open", fd_dest);
	cp(fd_src, fd_dest);
	try("close", close(fd_src));
	try("close", close(fd_dest));
	return 0;
}
