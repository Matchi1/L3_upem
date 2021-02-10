#include <stdio.h>
#include <stdlib.h>
#include "../include/Display.h"
#include "../include/Option.h"
#include "../include/Path.h"

extern Option opts;

/**
 * Verify if the specified file is a directory.
 * @param a pointor to a dirent structure.
 * @return 1 if the file is a directory else 0.
 */
int isDirectory(const struct dirent* d){
	if(d->d_type == 4)
		return 1;
	return 0;
}

/**
 * Display informations about a symbolic link
 * @param name the of the file
 * 		  s a stat structure
 */
void display_symb_link(const char* name){
	char buf[30];
	int index;

	index = readlink(name, buf, 30);
	buf[index] = '\0';
	printf("%s -> %s\n", name, buf);
}

/**
 * Display the name of the specified file.
 * @param filename the name of the specified file.
 */
void display_filename(const char* filename){
	printf("%s ", filename);
}

/**
 * Display the type of the specified file.
 * @param s a stat structure
 * @param 1 if the file is a symbolic link else 0.
 */
int display_type(struct stat* s){
	if(S_ISREG(s->st_mode))
		printf("Type of file : f ");
	else if(S_ISDIR(s->st_mode))
		printf("Type of file : d ");
	else if(S_ISLNK(s->st_mode)){
		printf("Type of file : l ");
		return 1;
	} else
		printf("Type of file : ? ");
	return 0;
}

/**
 * Display the owner of the specified file.
 * @param s a stat structure.
 */
void display_username(struct stat* s){
	struat passwd* pwd;
	struct group* gr;

	pwd = getpwuid(s->st_uid);
	gr = getgrgid(s->st_gid);

	if(!opts.numeric){
		printf("%s ", pwd->pw_name);
		printf("%s ", gr->gr_name);
	} else {
		printf("%d ", s->st_uid);
		printf("%d ", s->st_gid);
	}
}

void display_date(struct stat* s){
	int i;
	char* date = ctime(&(s->st_mtime));
	for(i = 0; date[i] != '\n' && date[i] != '\0'; i++);
	date[i] = '\0';
	printf("%s ", date);
}

/**
 * Display all the information about a file.
 * @param s a stat structure.
 * @param filename the name of a file.
 */
void display_detail(struct stat* s, const char* filename){
	int is_link;

	is_link = display_type(s);
	printf("%ld ", s->st_ino);
	display_username(s);
	printf("%5ld ", s->st_size);
	display_date(s);
	if(is_link)
		display_symb_link(filename);
	else
		printf("%s\n", filename);
}

/**
 * Display the information about a file
 * @param s a stat structure
 */
void display(Path* p, const char* name){
	struct stat s;

	try("lstat", lstat(p->path, &s));
	if(opts.long_list || opts.numeric)
		display_detail(&s, name);
	else
		display_filename(name);
}

/**
 * An auxiliary function to display all the files contained in the
 * specified directory.
 * @param dir stream of the specified directory.
 * @param path_dir path of the specfied directory.
 * @param directories name of all the directories contained in this directory.
 * @param length length of the array of directories.
 * @return number of directories.
 */
void display_dir_aux(Path* p, struct dirent **namelist, int length){
	int i, old_length;

	printf("%s :\n", p->path);
	for(i = 0; i < length; i++){
		if(strcmp(namelist[i]->d_name, ".") != 0 && strcmp(namelist[i]->d_name, "..") != 0){
			old_length = append(&p, namelist[i]->d_name);
			display(&p, namelist[i]->d_name);
			reset(&p, old_length);
		}
	}
	printf("\n");
}

/**
 * Display informations of the files in the directory
 * @param dir stream of files
 */
void display_dir(const char* path_dir){
	struct dirent **namelist;
	Path p;
	int i, length, old_length;

	init_path(&p, path_dir);
	length = scandir(path_dir, &namelist, NULL, compar);
	display_dir_aux(&p, namelist, length);

	if(opts.recursive){
		for(i = 0; i < length; i++){
			if(isDirectory(namelist[i]) 
				&& strcmp(namelist[i]->d_name, ".") != 0 
				&& strcmp(namelist[i]->d_name, "..") != 0){
				old_length = append(&p, namelist[i]->d_name);
				display_dir(&p);
				reset(&p, old_length);
			}
		}
	}
}
