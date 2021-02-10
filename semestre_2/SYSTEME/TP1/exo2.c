#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/sysmacros.h>
#include <limits.h>
#include <time.h>
#include <unistd.h>

/**
 * Display informations about a symbolic link
 * @param name the of the file
 * 		  s a stat structure
 */
void display_symb_link(struct stat s, const char* name){
	ssize_t tmpsiz;
	char buf[20];

	tmpsiz = readlink(name, buf, sizeof(buf));
	if(tmpsiz == -1){
		perror("readlink");
		exit(EXIT_FAILURE);
	}
	buf[tmpsiz - 1] = '\0';
	printf("'%s' points to '%s'\n", name, buf);
}

/**
 * Display the information about a file
 * @param s a stat structure
 */
void display(struct stat s, const char* name){
	printf("N° inode : %ld\n", s.st_ino);
	printf("size : %ld\n", s.st_size);
	printf("Last modification : %ld s\n", s.st_mtime);
	if(S_ISREG(s.st_mode))
		printf("Type of file : f\n");
	else if(S_ISDIR(s.st_mode))
		printf("Type of file : d\n");
	else if(S_ISLNK(s.st_mode)){
		printf("Type of file : l\n");
		display_symb_link(s, name);
	} else
		printf("Type of file : ?\n");
}


int main(int argc, const char* argv[]){
	struct stat s;
	if(argc < 2){
		fprintf(stderr, "Usage: %s <pathname>\n", argv[0]);
		return 1;
	}
	if(lstat(argv[1], &s) == -1){
		perror("lstat");
		exit(EXIT_FAILURE);
	}
	display(s, argv[1]);
	return 0;
}
