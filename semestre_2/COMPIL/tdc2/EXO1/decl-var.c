/* decl-var.c */
/* Traduction descendante récursive des déclarations de variables en C */
/* Compatible avec decl-var.lex */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "decl-var.h"
extern int lineno;  /* from lexical analyser */
int yylex();

int lookahead;
#define MAXSYMBOLS 256
STentry *symbolTable;
int STmax=MAXSYMBOLS; /* maximum size of symbol table */
int STsize=0;         /* size of symbol table */
char yylval[MAXNAME];

int Type(){
	if(INT == lookahead)
		return INTEGER;
	if(FLOAT == lookahead)
		return REAL;
	syntaxError();
	return -1;
}

void resteVars(int type){
	if(lookahead == ','){
		check(',');
		lookahead = yylex();
		check(IDENT);
		printf("%s of type %d\n", yylval, type);
		addVar(yylval, type);
		lookahead = yylex();
		resteVars(type);
	}
	return;
}

void Vars(int type){
	check(IDENT);
	printf("%s of type %d\n", yylval, type);
	addVar(yylval, type);
    lookahead = yylex();
	resteVars(type);
}

void DeclVar(){
	int type = Type();
	if(type == -1)
		exit(EXIT_FAILURE);
    lookahead = yylex();
	Vars(type);
    check(';');
    lookahead = yylex();
}

int main() {
    symbolTable=malloc(STmax*sizeof*symbolTable);
    if (!symbolTable) {
        printf("Run out of memory\n");
        exit(1);
    }
    lookahead = yylex();
	DeclVar();
    check(0);
    free(symbolTable);
    return 0;
}

void check(int token) {
    if (token!=lookahead) {
        syntaxError();
        exit(1);
    }
}
void addVar(const char name[], int type){
    int count;
    for (count=0;count<STsize;count++) {
        if (!strcmp(symbolTable[count].name,name)) {
            printf("semantic error, redefinition of variable %s near line %d\n",
            name, lineno);
            return;
        }
    }
    if (++STsize>STmax) {
        printf("too many variables near line %d\n", lineno);
        exit(1);
    }
    strcpy(symbolTable[STsize-1].name, name);
    symbolTable[STsize-1].type=type;
}
void syntaxError(){
    fprintf(stderr, "syntax error near line %d\n", lineno);
    exit(1);
}

