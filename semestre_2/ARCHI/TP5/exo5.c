#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <time.h>
#define N 1000000

int random_int(int max){
	int de;
	do {
		de = rand();
	} while(de >= INT_MAX - (INT_MAX % max));

	return de % max;
}

int fone(int taille, int *tab){
	int compte = 0, i;
	for(i = 0; i < taille; i++){
		if(tab[i] > 5 && tab[i] < 95)
				compte++;
	}
	return compte;
}

int ftwo(int taille, int *tab){
	int compte = 0, i;
	for(i = 0; i < taille; i++){
		if(tab[i] > 5)
			if(tab[i] < 95)
				compte++;
	}
	return compte;
}

int main(){
	int tab[N], seuil = 200, i;
	unsigned int begin, end;
	int compte;
	for(i = 0; i < N; i++)
		tab[i] = random_int(101);
	compte = 0;
	for(i = 0; i < N; i++){
		if(tab[i] > 5 && tab[i] < 95)
				compte++;
	}
	compte = 0;
	for(i = 0; i < N; i++){
		if(tab[i] > 5)
			if(tab[i] < 95)
				compte++;
	}
	//ftwo(N, tab);
	/*
	begin = clock();
	printf("nombre de valeur inférieure au seuil : %d\n", fone(N, tab));
	end = clock();
	printf("temps d'exécution de fone: %f s\n", (end - begin) / (float)CLOCKS_PER_SEC);

	begin = clock();
	printf("nombre de valeur inférieure au seuil : %d\n", ftwo(N, tab));
	end = clock();
	printf("temps d'exécution de ftwo: %f s\n", (end - begin) / (float)CLOCKS_PER_SEC);
	*/
	return 0;
}
