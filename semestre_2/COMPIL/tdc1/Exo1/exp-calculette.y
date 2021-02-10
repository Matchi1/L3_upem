%{
/* exp-calculette.y */
/* Syntaxe des expressions */
#include <stdio.h>
#include <string.h>
int yylex();
void yyerror(char *);
extern int lineno;
%}
%union {
    int num;
    char comp[3];
    char addsub;
    char divstar;
}

%token <num> NUM
%token <comp> EQ
%token <addsub> ADDSUB
%token <divstar> DIVSTAR
%token OR AND
%type <num> F T E L EB TB FB 

%%
L   :  EB '.' 	   { printf("%d\n", $1); }
    ; 
EB  :  EB OR TB    { $$ = ($1 || $3); }
    |  TB 
    ;
TB  :  TB AND FB   { $$ = ($1 && $3); }
    |  FB 
    ;
FB  :  E EQ E	   { switch(strcmp($2, "==")){
						case 0: $$ = ($1 == $3); break;
						default: $$ = ($1 != $3);
					}
				}
    |  E
    ;
E   :  E ADDSUB T  { switch($2){
						case '+': $$ = $1 + $3; break;
						default: $$ = $1 - $3;
					}
				}
    |  T 
    ;    
T   :  T DIVSTAR F { switch($2){
						case '/': 
							($3 != 0) ? ($$ = $1 / $3) : printf("ERROR!!!\n"); break;
						case '*': 
							$$ = $1 * $3; break;
						default: 
							($3 != 0) ? ($$ = $1 % $3) : printf("ERROR!!!\n");
					}
				}
    |  F 
    ;
F   :  ADDSUB F    { switch($1){
						case '+': $$ = + $2; break;
						default: $$ = - $2;
					} 
				}
    |  '!' F	   { $$ = !$2; } 
    |  '(' EB ')'  { $$ = ($2); }
    |  NUM
    ;
%%
int main(int argc, char** argv) {
  yyparse();
  return 0;
}
void yyerror(char *s){
  fprintf(stderr, "%s near line %d\n", s, lineno);
}
