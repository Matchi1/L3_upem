#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include "../include/Option.h"

void usage(const char* prog_name){
	fprintf(stderr, "Usage: %s [-Rln] file1 file2 file3 ...\n", prog_name);
}

/**
 * Verify if no option has been inputted.
 * @param opts the options.
 * @return 1 if no options has been inputted else 0.
 */
int no_option(Option opts){
	if(opts.long_list == 0 && opts.numeric == 0 && opts.recursive == 0)
		return 1;
	return 0;
}

/**
 * Initialize an Option structure.
 * @param opts a pointor to an Option structure.
 */
void init_options(Option* opts){
	opts->numeric = 0;
	opts->recursive = 0;
	opts->long_list = 0;
}

/**
 * browse all inputted options in the arguments.
 * @param argc number of argument.
 * @param argv array of argument.
 * @param opts a pointor to an Option structure.
 */
void check_options(int argc, char* argv[], Option* opts){
	int opt;
	while((opt = getopt(argc, argv, "Rln")) != -1){
		switch(opt){
			case 'R':
				opts->recursive = 1; break;
			case 'l':
				opts->long_list = 1; break;
			case 'n':
				opts->numeric = 1; break;
			default:
				usage(argv[0]);
				exit(EXIT_FAILURE);
		}
	}
}
