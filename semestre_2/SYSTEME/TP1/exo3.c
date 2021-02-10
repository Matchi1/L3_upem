#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/sysmacros.h>
#include <dirent.h>
#include <time.h>
#include <unistd.h>

/**
 * Display informations about a symbolic link
 * @param name the of the file
 * 		  s a stat structure
 */
void display_symb_link(struct stat s, const char* name){
	ssize_t bufsiz;
	char* buf;

	bufsiz = s.st_size + 1;
	buf = (char*)malloc(sizeof(char) * bufsiz);
	if(NULL == buf){
		perror("malloc");
		exit(EXIT_FAILURE);
	}
	readlink(name, buf, bufsiz);
	printf("'%s' points to '%s'\n", name, buf);
	free(buf);
}

/**
 * Display the information about a file
 * @param s a stat structure
 */
void display(struct stat s, const char* name){
	printf("Name : %100s \t", name);
	printf("N° inode : %10ld \t", s.st_ino);
	printf("size : %10ld \t", s.st_size);
	printf("Last modification : %10ld s \t", s.st_mtime);
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

/**
 * Display informations of the files in the directory
 * @param dir stream of files
 */
void display_dir(DIR* dir, const char* path_dir){
	struct dirent* d;
	struct stat s;
	char path[500];
	for(d = readdir(dir); d != NULL; d = readdir(dir)){
		snprintf(path, 100, "%s%s%s", path_dir, "/", d->d_name);
		if(lstat(path, &s) == -1){
			perror("lstat");
			exit(EXIT_FAILURE);
		}
		if(strcmp(d->d_name, ".") != 0 && strcmp(d->d_name, "..") != 0)
			display(s, path);
	}
}

/**
 * Browse all the files in argument and display their informations
 * @param argc number of argument
 * 		  argv argument
 */
void browse_files(int argc, const char* argv[]){
	int i;
	struct stat s;
	DIR* dir;

	for(i = 1; i < argc; i++){
		if(lstat(argv[i], &s) == -1){
			perror("lstat");
			exit(EXIT_FAILURE);
		}
		if(S_ISDIR(s.st_mode)){
			dir = opendir(argv[i]);
			display_dir(dir, argv[i]);
		} else
			display(s, argv[i]);
	}
}

int main(int argc, const char* argv[]){
	struct stat s;
	DIR* dir;

	if(argc < 2){
		if(lstat(".", &s) == -1){
			perror("lstat");
			exit(EXIT_FAILURE);
		}
		dir = opendir(".");
		display_dir(dir, ".");
	}
	browse_files(argc, argv);
	return 0;
}
