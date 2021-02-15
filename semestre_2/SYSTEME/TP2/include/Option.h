#ifndef __OPTION__
#define __OPTION__


typedef struct {
	int long_list, numeric, recursive;
	char* prog_name;
}Option;

int no_option(Option opts);

void init_options(Option* opts);

void check_options(int argc, char* argv[], Option* opts);

#endif
