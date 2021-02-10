%{
    #include <stdio.h>
    int yylex();
    int yyerror(char* s);
%}

%token OU ET NON VRAI FAUX

%%
E   : E OU T
    | T
    ;
T   : T ET F
    | F
    ;
F   : NON F
    | '(' E ')'
    | VRAI
    | FAUX
    ;
%%

int yyerror(char* s){
    fprintf(stderr, "%s\n", s);
    return 0;
}

int main(void){
    /* yyparse() renvoie 1 quand la grammaire n'est pas reconnue
    0 sinon. */
    int valeur = yyparse();
    return !valeur;
}