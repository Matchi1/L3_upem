#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/sysmacros.h>
#include <time.h>
#include <unistd.h>

/**
 * Display the information about a file
 * @param s a stat structure
 */
void display(struct stat s){
	printf("N° inode : %ld\n", s.st_ino);
	printf("size : %ld\n", s.st_size);
	printf("Last modification : %ld s\n", s.st_mtime);
	if(S_ISREG(s.st_mode))
		printf("Type of file : f\n");
	else if(S_ISDIR(s.st_mode))
		printf("Type of file : d\n");
	else
		printf("Type of file : ?\n");
}

int main(int argc, const char* argv[]){
	struct stat s;
	if(argc < 2){
		fprintf(stderr, "Usage: %s <pathname>\n", argv[0]);
		return 1;
	}
	if(stat(argv[1], &s) == -1){
		perror("stat");
		exit(EXIT_FAILURE);
	}
	display(s);
	return 0;
}
