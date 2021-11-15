#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <signal.h>

#define BUFFER_SIZE 50

typedef struct {
	int append, ignore;
}Options;

void try(char* name, int ret_value){
	if(ret_value == -1){
		perror(name);
		exit(EXIT_FAILURE);
	}
}

void init_option(Options *opt){
	opt->append = 0;
	opt->ignore = 0;
}

void check_option(Options *opt, int argc, char *argv[]){
	int n = 0;
	while(n != -1){
		switch(n = getopt(argc, argv, "ai")){
			case 'a':
				opt->append = 1; break;
			case 'i':
				opt->ignore = 1; break;
			default:
				break;
		}
	}
}

void handler(int s){
	printf("interuption évitée\n");
}

int main(int argc, char *argv[]){
	Options opt;
	int i = 0, fd, size = 0, current_fd = STDIN_FILENO;
	struct sigaction sig;
	char buffer[BUFFER_SIZE];

	sig.sa_handler = handler;
	sigemptyset(&sig.sa_mask);
	sig.sa_flags = 0;

	init_option(&opt);
	check_option(&opt, argc, argv);
	if(opt.ignore == 1)
		try("sigaction", sigaction(SIGINT, &sig, NULL));

	for(i = optind; optind < argc; i++){
		if(argv[i] == NULL)
			break;
		if(opt.append == 0)
			try("open", fd = open(argv[i], O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR));
		else
			try("open", fd = open(argv[i], 'a'));
		try("read", size = read(STDIN_FILENO, buffer, BUFFER_SIZE));
		try("lseek", lseek(STDIN_FILENO, 0, SEEK_SET));
		try("write", write(fd, buffer, size));
		try("close", close(fd));
	}
	try("write", write(STDOUT_FILENO, buffer, size));
	return 0;
}
