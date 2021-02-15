#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <unistd.h>
#include "../include/Option.h"
#include "../include/Display.h"
#include "../include/Path.h"

Option opts;

/**
 * A convenience function to make our code slightly more readable
 * @param sys_call the name of the systeme call
 * @param ret_val the return value of this systeme call
 */
void try(const char* sys_call, int ret_val){
	if(ret_val == -1){
		perror(sys_call);
		exit(EXIT_FAILURE);
	}
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
