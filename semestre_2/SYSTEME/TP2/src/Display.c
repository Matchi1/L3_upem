#include <stdio.h>
#include <string.h>
#include <dirent.h>
#include <sys/stat.h>
#include <pwd.h>
#include <grp.h>
#include <time.h>
#include <unistd.h>
#include "../include/Display.h"
#include "../include/Option.h"

/**
 * This Option structure is set as a global
 * variable because it is initialized once and can't be
 * modified during the execution of the program.
 */
extern Option opts;

/**
 * A convenience function to make our code slightly more readable
 * @param sys_call the name of the systeme call
 * @param ret_val the return value of this systeme call
 */
extern void try(const char* sys_call, int ret_val);

/**
 * Compare 2 dirent structure.
 * @param d1 a dirent structure.
 * @param d2 a dirent structure.
 */
int compar(const struct dirent **d1, const struct dirent **d2){
	return strcmp((*d1)->d_name, (*d2)->d_name);
}

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
 * Display the read permission of a file.
 * @param s a pointor to a stat structure.
 * @param mask the mask of the permission.
 */
void read_permission(struct stat* s, int mask){
	if(s->st_mode & mask)
		printf("r");
	else
		printf("-");
}

/**
 * Display the write permission of a file.
 * @param s a pointor to a stat structure.
 * @param mask the mask of the permission.
 */
void write_permission(struct stat* s, int mask){
	if(s->st_mode & mask)
		printf("w");
	else
		printf("-");
}

/**
 * Display the execute permission of a file.
 * @param s a pointor to a stat structure.
 * @param mask the mask of the permission.
 */
void exec_permission(struct stat* s, int mask){
	if((s->st_mode & mask) != 0)
		printf("x");
	else
		printf("-");
}

/**
 * Display the owner's permission on a file.
 * @param s a pointor to a stat structure.
 */
void owner_permission(struct stat* s){
	read_permission(s, S_IRUSR);
	write_permission(s, S_IWUSR);
	exec_permission(s, S_IXUSR);
}

/**
 * Display the group's permission on a file.
 * @param s a pointor to a stat structure.
 */
void group_permission(struct stat* s){
	read_permission(s, S_IRGRP);
	write_permission(s, S_IWGRP);
	exec_permission(s, S_IXGRP);
}

/**
 * Display the other's permission on a file.
 * @param s a pointor to a stat structure.
 */
void other_permission(struct stat* s){
	read_permission(s, S_IROTH);
	write_permission(s, S_IWOTH);
	exec_permission(s, S_IXOTH);
}

/**
 * Display all permissions of a file.
 * @param s a pointor to a stat structure.
 */
void display_permission(struct stat* s){
	owner_permission(s);
	group_permission(s);
	other_permission(s);
	printf(" ");
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
		printf("f ");
	else if(S_ISDIR(s->st_mode))
		printf("d ");
	else if(S_ISLNK(s->st_mode)){
		printf("l ");
		return 1;
	} else
		printf("? ");
	return 0;
}

/**
 * Display the owner of the specified file.
 * @param s a stat structure.
 */
void display_username(struct stat* s){
	struct passwd* pwd;
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

/**
 * Display the date of modification of a file.
 * @param s a pointor to a stat structure.
 */
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
	display_permission(s);
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
		old_length = append(p, namelist[i]->d_name);
		display(p, namelist[i]->d_name);
		reset(p, old_length);
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
			if(isDirectory(namelist[i]) && strcmp(namelist[i]->d_name, ".") != 0 
					&& strcmp(namelist[i]->d_name, "..") != 0){
				old_length = append(&p, namelist[i]->d_name);
				display_dir(p.path);
				reset(&p, old_length);
			}
		}
	}
}
