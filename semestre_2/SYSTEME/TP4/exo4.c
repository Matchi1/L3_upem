#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

/* On remarque que l'adresse de i et la valeur de i dans le
 * processus père et fils sont les mêmes */
/* Malgré le fait qu'on ait modifié la valeur de i dans le processus 
 * fils, cela n'a pas d'impact sur le valeur de i dans le processus père */
/* Les adresses sont identiques mais les valeurs ne le sont pas, donc on peut
 * en déduire qu'il y a une sorte d'incohérence avec les adresses */
int main(int argc, char *argv[]){
	int i = 10;
	switch(fork()){
		case -1:
			perror("fork");
			exit(EXIT_FAILURE);
		case 0:
			printf("fils :\n");
			i = 1;
			printf("%p : %d\n", (void*) &i, i);
			break;
		default:
			printf("père :\n");
			printf("%p : %d\n", (void*) &i, i);
			break;
	}
	return 0;
}
