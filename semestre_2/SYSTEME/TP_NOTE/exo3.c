#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

void try(char *name, int ret_value){
	if(ret_value == -1){
		perror(name);
		exit(EXIT_FAILURE);
	}
}

void max_size(char* path){
	int length_dir = strlen(path);
	int i, n, first = 1;
	char current_path[20];
	struct dirent **namelist;
	struct stat current_s, next_s;

	sprintf(current_path, "%s/", path);
	try("scandir", n = scandir(current_path, &namelist, NULL, NULL));
	for(; n != 0; n--){
		sprintf(&(current_path[length_dir + 1]), "%s", namelist[i].d_name);
		if(first){
			strcpy(path, current_path);
			try("lstat", lstat(path, &current_s));
		} else {
			try("lstat", lstat(current_path, &next_s));
			if(current_s.st_size < next_s.st_size){
				strcpy(path, current_path);
				current_s = next_s;
			}
		}
	}
}

void display_stat(char *path){
	struct stat s;

	try("lstat", lstat(path, &s));
	if(S_ISDIR(s.st_mode))
		max_size(path);
	try("lstat", lstat(path, &s));
	printf("nom du fichier : %s\n", path);
	printf("taille du fichier : %ld\n", s.st_size);
}

int main(int argc, char *argv[]){
	display_stat(argv[1]);
	return 0;
}
