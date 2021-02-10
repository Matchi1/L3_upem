#include <stdio.h>
#include <stdlib.h>
#include "../include/Option.h"

void usage(const char* prog_name){
	fprintf(stderr, "Usage: %s [-Rln] file1 file2 file3 ...\n", prog_name);
}

int no_option(Option opts){
	if(opts.long_list == 0
		&& opts.numeric == 0
		&& opts.recursive == 0)
		return 1;
	return 0;
}

void init_options(Option* opts){
	opts->numeric = 0;
	opts->recursive = 0;
	opts->long_list = 0;
}

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
