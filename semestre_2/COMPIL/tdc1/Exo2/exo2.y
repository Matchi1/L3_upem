%{
/* exo2.y */
/* Syntaxe des expressions */
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(char *);
%}

%code requires {
	#include "Node.h"
}

%union {
	Tree tree;
}
%type <tree> L S T

%%
L : S '.' { display_tree($1); free_tree($1); }
  ;

S : 'a' S { $$ = make_node('S');
  			$$->g = make_node('a');
			$$->d = $2;
		}
  | T	  { $$ = make_node('S');
  			$$->g = $1;
			$$->d = make_node('T'); 
		}
  ;

T : T 'a' { $$ = make_node('T');
  			$$->g = $1;
			$$->d = make_node('a');
		} 
  | 'b'   { $$ = make_node('T');
  			$$->g = make_node('b');
			$$->d = make_node(0);
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
