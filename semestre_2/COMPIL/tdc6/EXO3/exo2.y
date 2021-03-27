%{
/* exo2.y */
/* Syntaxe des expressions */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int yylex();
void yyerror(char *);
%}

%code requires {
	#include "abstract-tree.h"
}

%union {
	Node* node;
}

%token CHARACTERA CHARACTERB
%type <node> L S T

%%
L : S '.' { printTree($1); deleteTree($1); }
  ;

S : CHARACTERA S { 
  					$$ = makeNode(CharLiteral);
					$$->u.character = 'a';
					addChild($$, $2);
				}
  | T	{ $$ = $1; }
  ;

T : T CHARACTERA { 
  					$$ = makeNode(CharLiteral);
					$$->u.character = 'a';
				   	addChild($$, $1);
  				}
  | CHARACTERB   { 
  					$$ = makeNode(None);
					$$->u.character = 'b';
  				}
  ;
%%

int main(int argc, char** argv) {
  yyparse();
  return 0;
}
void yyerror(char *s){
  fprintf(stderr, "error\n");
}
