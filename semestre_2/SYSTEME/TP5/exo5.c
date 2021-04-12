#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

struct {
	char *name;
	int fd[2];
} proc[] = {{"add", {0, 0}}, {"sub", {0, 0}},
	{"mul", {0, 0}}, {"div", {0, 0}},
	{NULL, {0, 0}}};

void try(char* name, int retValue){
	if(retValue == -1){
		perror(name);
		exit(EXIT_FAILURE);
	}
}

void write_nb(){
	char name[4];
	int i, a, b;
	while(scanf("%s%d%d", name, &a, &b) == 3){
		for(i = 0; proc[i].name != NULL; i++){
			if(strcmp(proc[i].name, name) == 0){
				try("dup2", dup2(proc[i].fd[1], 1));
				printf("%d %d\n", a, b);
			}
		}
	}
}

void close_fd(int index){
	int i;
	for(i = 0; i < index; i++){
		try("close", close(proc[i].fd[0]));
		try("close", close(proc[i].fd[1]));
	}
	try("close", close(proc[i].fd[1]));
}

void create_sub_process(){
	int i;
	for(i = 0; proc[i].name != NULL; i++){
		try("pipe", pipe(proc[i].fd));
		switch(fork()){
			case -1:
				try("fork", -1); break;
			case 0:
				try("dup2", dup2(proc[i].fd[0], 0));
				close_fd(i);
				try("execl", execl(proc[i].name, proc[i].name, NULL));
				break;
			default: 
				try("close", proc[i].fd[0]);
				break;
		}
	}
}

int main(void){
	setbuf(stdout, NULL);
	/* création des sous-processus pour les différents calculs */
	create_sub_process();
	
	/* Attend l'entrée de l'utilisateur pour pouvoir diriger 
	 * le calcul dans le sous-processus correspondant */
	write_nb();
	return 0;
}
