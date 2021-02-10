#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/sysmacros.h>
#include <dirent.h>
#include <time.h>
#include <pwd.h>
#include <unistd.h>
#include <getopt.h>
#include <grp.h>

#define MAX_LENGTH 500

typedef struct {
	int long_list, numeric, recursive;
	char* prog_name;
}Option;

Option opts;

int no_option(){
	if(opts.long_list == 0
		&& opts.numeric == 0
		&& opts.recursive == 0)
		return 1;
	return 0;
}

int is_recursive(){
	return opts.recursive;
}
int is_long_list(){
	return opts.long_list;
}
int is_numeric(){
	return opts.numeric;
}

/**
 * A convenience function to make our code slightly more readable
 * @param sys_call the name of the systeme call
 * @param ret_val the return value of this systeme call
 */
static void try(const char* sys_call, int ret_val){
	if(ret_val == -1){
		perror(sys_call);
		exit(EXIT_FAILURE);
	}
}

/**
 * Compare 2 dirent structure.
 * @param d1 a dirent structure.
 * @param d2 a dirent structure.
 */
int compar(const struct dirent **d1, const struct dirent **d2){
	return strcmp((*d1)->d_name, (*d2)->d_name);
}

/**
 * Concat the path of a directory with the name of the file
 * contained in this directory.
 * @param path path of the directory.
 * @param file_name name of the specified file.
 * @return the concated path of the file.
 */
void concat_path(char* full_path, int max_length, const char* path_dir, const char* file_name){
	if(strlen(path_dir) + strlen(file_name) + 1 > MAX_LENGTH){
		fprintf(stderr, "concat_path : Not enough space\n");
		exit(EXIT_FAILURE);
	}
	snprintf(full_path, max_length, "%s%s%s", path_dir, "/", file_name);
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
	struct passwd* pwd;
	struct group* gr;

	pwd = getpwuid(s->st_uid);
	gr = getgrgid(s->st_gid);

	if(!is_numeric){
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
void display(const char* path_dir, const char* name){
	struct stat s;
	char path[MAX_LENGTH];

	concat_path(path, MAX_LENGTH, path_dir, name);
	try("lstat", lstat(path, &s));
	if(is_long_list() || is_numeric())
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
void display_dir_aux(const char* path_dir, struct dirent **namelist, int length){
	int i;

	printf("%s :\n", path_dir);
	for(i = 0; i < length; i++){
		if(strcmp(namelist[i]->d_name, ".") != 0 && strcmp(namelist[i]->d_name, "..") != 0)
			display(path_dir, namelist[i]->d_name);
	}
	printf("\n");
}

/**
 * Display informations of the files in the directory
 * @param dir stream of files
 */
void display_dir(const char* path_dir){
	struct dirent **namelist;
	char path[MAX_LENGTH];
	int i, length;
	
	length = scandir(path_dir, &namelist, NULL, compar);
	display_dir_aux(path_dir, namelist, length);

	if(opts.recursive){
		for(i = 0; i < length; i++){
			if(isDirectory(namelist[i]) 
				&& strcmp(namelist[i]->d_name, ".") != 0 
				&& strcmp(namelist[i]->d_name, "..") != 0){
				concat_path(path, MAX_LENGTH, path_dir, namelist[i]->d_name);
				display_dir(path);
			}
		}
	}
}


/**
 * Browse all the files in argument and display their informations
 * @param argc number of argument
 * 		  argv argument
 */
void browse_files(int argc, char* const argv[]){
	struct stat s;
	
	if(argc < 3 && !no_option())
		display_dir(".");
	else {
		for(; optind < argc; optind++){
			try("lstat", lstat(argv[optind], &s));
			if(S_ISDIR(s.st_mode))
				display_dir(argv[optind]);
			else
				fprintf(stderr, "'%s' is not a directory\n", argv[optind]);
		}
	}
}

void usage(const char* prog_name){
	fprintf(stderr, "Usage: %s [-Rln] file1 file2 file3 ...\n", prog_name);
}

void init_options(){
	opts.numeric = 0;
	opts.recursive = 0;
	opts.long_list = 0;
}

void check_options(int argc, char* argv[]){
	int opt;
	while((opt = getopt(argc, argv, "Rln")) != -1){
		switch(opt){
			case 'R':
				opts.recursive = 1; break;
			case 'l':
				opts.long_list = 1; break;
			case 'n':
				opts.numeric = 1; break;
			default:
				usage(argv[0]);
				exit(EXIT_FAILURE);
		}
	}
}

int main(int argc, char* argv[]){
	int i;
	init_options();

	if(argc < 2){
		display_dir(".");
		return 0;
	}
	check_options(argc, argv);
	browse_files(argc, argv);
	return 0;
}
