#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

#define MAX 10
#define BLOC_SIZE 20

void try(const char* sysCall, int retValue){
	if(retValue < 0){
		perror(sysCall);
		exit(EXIT_FAILURE);
	}
}

void usage(const char* progName){
	printf("%s -[cwl] <filename>\n", progName);
}

int is_delimiter_word(char chr){
	if(chr == ' ' || chr == '\t' || chr == '\n')
		return 1;
	return 0;
}

int is_delimiter_line(char chr){
	if(chr == '\n')
		return 1;
	return 0;
}

int count_delimiter_word(int length, const char* buf){
	int i, count;
	count = 0;
	for(i = 0; i < length; i++){
		count += is_delimiter_word(buf[i]);
	}
	return count;
}

int count_delimiter_line(int length, const char* buf){
	int i, count;
	count = 0;
	for(i = 0; i < length; i++){
		count += is_delimiter_line(buf[i]);
	}
	return count;
}

void count_character(const char* fileName){
	char buf[BLOC_SIZE];
	char str_count[MAX];
	int fd, size, count, length;

	count = 0;
	fd = open(fileName, O_RDONLY);
	try("open", fd);
	while(1){
		try("read", (size = read(fd, buf, BLOC_SIZE)));
		count += size;
		if(size < 1)
			break;
	}
	try("close", close(fd));
	length = sprintf(str_count, "%d\n", count);
	try("write", write(STDOUT_FILENO, str_count, length));
}

void count_word(const char* fileName){
	char buf[BLOC_SIZE];
	char str_count[MAX];
	int fd, size, count, length;

	count = 0;
	try("open", (fd = open(fileName, O_RDONLY)));
	while(1){
		try("read", (size = read(fd, buf, BLOC_SIZE)));
		count += count_delimiter_word(size, buf);
		if(size < BLOC_SIZE)
			break;
	}
	try("close", close(fd));
	length = sprintf(str_count, "%d\n", count);
	try("write", write(STDOUT_FILENO, str_count, length));
}

void count_line(const char* fileName){
	char buf[BLOC_SIZE];
	char str_count[MAX];
	int fd, size, count, length;

	count = 0;
	try("open", (fd = open(fileName, O_RDONLY)));
	while(1){
		try("read", (size = read(fd, buf, BLOC_SIZE)));
		count += count_delimiter_line(size, buf);
		if(size < BLOC_SIZE)
			break;
	}
	try("close", close(fd));
	length = sprintf(str_count, "%d\n", count);
	try("write", write(STDOUT_FILENO, str_count, length));
}

void options(int argc, char *argv[]){
	int option;
	while((option = getopt(argc, argv, "cwl")) != -1){
		switch(option){
			case 'c':
				count_character(argv[2]); break;
			case 'w':
				count_word(argv[2]); break;
			case 'l':
				count_line(argv[2]); break;
			default: 
				usage(argv[0]);
		}
	}
}

int main(int argc, char *argv[]){
	if(argc < 3){
		usage(argv[0]);
		return 1;
	}
	options(argc, argv);
	return 0;
}
