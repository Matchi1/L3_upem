#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <time.h>
#define N 10000

int compte_inf_seuil(int seuil, int taille, int *tab){
	int compte = 0, i;
	for(i = 0; i < taille; i++){
		if(tab[i] < seuil)
			compte++;
	}
	return compte;
}

int random_int(int max){
	int de;
	do {
		de = rand();
	} while(de >= INT_MAX - (INT_MAX % max));

	return de % max;
}

/*
 * Ignorer les premières valeurs dans une boucle
 * */
int main(){
	int tab[N], i;
	int seuil = 500;
	unsigned int begin, end;
	for(i = 0; i < N; i++)
		tab[i] = random_int(1001);
	begin = clock();
	printf("nombre de valeur inférieure au seuil : %d\n", compte_inf_seuil(seuil, N, tab));
	end = clock();
	printf("temps d'exécution : %f\n", (end - begin) / (float)CLOCKS_PER_SEC);
	return 0;
}

