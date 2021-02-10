%{
/* exp-calculette.y */
/* Syntaxe des expressions */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "Node.h"
int yylex();
void yyerror(char *);
extern int lineno;
%}

%code requires {
#include "Node.h"
}

%union {
    int num;
    char comp[3];
    char addsub;
    char divstar;
	Tree tree;
}

%token <num> NUM
%token <comp> EQ
%token <addsub> ADDSUB
%token <divstar> DIVSTAR
%token OR AND
%type <tree> F T E L EB TB FB 

%%
L   :  EB '.' 	   { display_tree($1); free_tree($1); }
    ; 
EB  :  EB OR TB    { $$ = make_node(); 
					 strcpy($$->dt.op, "||");
					 $$->g = $1;
					 $$->d = $3;
				}
    |  TB 
    ;
TB  :  TB AND FB   { $$ = make_node();
					 strcpy($$->dt.op, "&&");
					 $$->g = $1;	
					 $$->d = $3;	
				}
    |  FB 
    ;
FB  :  E EQ E	   {
					$$ = make_node();
					switch(strcmp($2, "==")){
						case 0: strcpy($$->dt.op, "=="); break;
						default: strcpy($$->dt.op, "!=");
					}
					$$->g = $1;
					$$->d = $3;
				}
    |  E
    ;
E   :  E ADDSUB T  { 
					$$ = make_node();
					switch($2){
						case '+': strcpy($$->dt.op, "+"); break;
						default: strcpy($$->dt.op, "-");
					}
					$$->g = $1;
					$$->d = $3;
				}
    |  T 
    ;    
T   :  T DIVSTAR F { 
					$$ = make_node();	
					switch($2){
						case '/': 
							strcpy($$->dt.op, "/"); break;
						case '*': 
							strcpy($$->dt.op, "*"); break;
						default: 
							strcpy($$->dt.op, "%");
					}
					$$->g = $1;
					$$->d = $3;
				}
    |  F
    ;
F   :  ADDSUB F    { 
					$$ = make_node();
					switch($1){
						case '+': strcpy($$->dt.op, "+"); break;
						default: strcpy($$->dt.op, "-");
					} 
					$$->g = NULL;
					$$->d = $2;
				}
    |  '!' F	   { $$ = make_node(); 
					 strcpy($$->dt.op, "!");
					 $$->g = NULL;
					 $$->d = $2;		
				} 
    |  '(' EB ')'  { $$ = $2; }
    |  NUM		   { $$ = make_node();
					 $$->dt.val = $1;
					 strcpy($$->dt.op, "NONE");
					 $$->g = NULL;
					 $$->d = NULL;
				}
    ;
%%
int main(int argc, char** argv) {
  yyparse();
  return 0;
}
void yyerror(char *s){
  fprintf(stderr, "%s near line %d\n", s, lineno);
}
