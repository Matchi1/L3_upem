%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror();
extern int lineno;
%}

%code requires {
	#include "decl-var.h"
}

%union {
	char name[25];
	STentry* stentry;
}

%token INT FLOAT IDENT
%type <stentry> DeclVar Type Vars resteVars 

%%
DeclVar		: Type Vars 			
			;
Type		: INT					
			| FLOAT					
			;
Vars		: IDENT resteVars ';'
			;
resteVars	: ',' IDENT resteVars
		  	|
			;
%%

int main(int argc, char** argv) {
  yyparse();
  return 0;
}

