%{
    #define MAXCARAC 5
    char mot[MAXCARAC];
    int compteur;
    int verif_compteur(int* compteur, char* mot);
%}

%option nounput
%option noinput
%x LIRE

%%
[a-zA-Z] {ECHO; compteur = 1; BEGIN LIRE; }

<LIRE>[a-zA-Z] {
        ECHO;
        compteur++; 
        if(verif_compteur(&compteur) == 1)
            BEGIN INITIAL;
            }
<LIRE>.
<LIRE><<EOF>> {printf("%s\n", mot); return 0; }
%%

int verif_compteur(int* compteur){
    if(*compteur == 5){
        *compteur = 0;
        printf("\n");
        return 1;
    }
    return 0;
}