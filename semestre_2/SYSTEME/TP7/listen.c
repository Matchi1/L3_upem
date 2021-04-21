#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/select.h>
#include <sys/time.h>

struct {
	char *msg;
	char *delay;
	pid_t pid;
	int fd;
} proc[] = {{"First  process ---", "1000000", 0, 0},
	{"Second process +++", "3000000", 0, 0},
	{"Third  process ###", "9000000", 0, 0},
	{NULL, NULL, 0, 0}
};

int maxfd = -1;

void try(char* name, int retValue){
	if(retValue == -1){
		perror(name);
		exit(EXIT_FAILURE);
	}
}

void close_fd(int index, int pipes[][2]){
	int i;
	for(i = 0; i < index; i++){
		try("close", close(pipes[i][0]));
		try("close", close(pipes[i][1]));
	}
	try("close", close(pipes[i][1]));
}

void create_sub_process(){
	for (int i = 0; proc[i].msg; i++) {
		int p[2];
		try("pipe", pipe(p));
		proc[i].pid = fork();
		switch (proc[i].pid) {
			case -1:
				perror("fork");
				exit(1);
			case 0:
				for (int j = 0; j < i; j++) {
					try("close", close(proc[j].fd));
				}
				try("dup2", dup2(p[1], 1));
				try("close", close(p[0]));
				try("close", close(p[1]));
				try("execl", execl("repeat", "repeat", proc[i].msg, proc[i].delay, NULL));
				break;
			default:
				try("close", close(p[1]));
				proc[i].fd = p[0];
				if (proc[i].fd > maxfd) {
					maxfd = proc[i].fd;
				}
				break;
		}
	}
}

void use_select(){
	int i, len;
	char buf[25];
	fd_set rfds;	

	while(1){
		FD_ZERO(&rfds);
		for(i = 0; proc[i].msg != NULL; i++)
			FD_SET(proc[i].fd, &rfds);

		try("select", select(maxfd + 1, &rfds, NULL, NULL, NULL));
		for(i = 0; proc[i].msg != NULL; i++){
			if(FD_ISSET(proc[i].fd, &rfds)){
				len = read(proc[i].fd, buf, 25);
				buf[len] = '\0';
				write(STDOUT_FILENO, buf, len + 1);
			}
		}
	}
}

int main(int argc, const char* argv[]){
	create_sub_process();
	use_select();
	return 0;
}
