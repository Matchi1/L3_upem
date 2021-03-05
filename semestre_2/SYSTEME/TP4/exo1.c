#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

void part1(){
	printf("bonjour\n");
	fork();
	/* Affichage en double car on créer un processus fils */
	printf("au revoir\n");
}

void part2(char* args[]){
	execvp(args[0], args);
	/* le message ci-dessous ne s'affiche pas car le programme s'arrête au moment où l'on exécute
	 * la fonction execvp() pour ls */
	printf("ls est terminé\n");
}

void part3(char* args[]){
	switch(fork()){
		case -1: 
			perror("fork"); 
			exit(EXIT_FAILURE);
		case 0: 
			execvp(args[0], args); 
			perror("execvp");
			exit(EXIT_FAILURE);
		default: printf("ls est terminé\n"); break;
	}
}

int main(void){
	char* args[] = {"ls", NULL};
	part3(args);
	return 0;
}
