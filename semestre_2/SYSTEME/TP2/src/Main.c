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
#include <grp.h>
#include "../include/Option.h"
#include "../include/Display.h"
#include "../include/Path.h"

Option opts;

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
 * Browse all the files in argument and display their informations
 * @param argc number of argument
 * 		  argv argument
 */
void browse_files(int argc, char* const argv[]){
	struct stat s;
	
	if(argc < 3 && !no_option(opts))
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

int main(int argc, char* argv[]){
	init_options(&opts);

	if(argc < 2){
		display_dir(".");
		return 0;
	}
	check_options(argc, argv, &opts);
	browse_files(argc, argv);
	return 0;
}
