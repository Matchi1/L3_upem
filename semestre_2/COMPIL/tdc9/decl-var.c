/* decl-var.c */
/* Traduction descendante récursive des déclarations de variables en C */
/* Compatible avec decl-var.lex */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "decl-var.h"
extern int lineno;  /* from lexical analyser */

#define MAXFUNCS 100

STentry symbolTable[MAXSYMBOLS];
STfunc STFunctions[MAXFUNCS];
int STfuncSize = 0;
int STmax = MAXSYMBOLS; /* maximum size of symbol table */

void addVarAux(STfunc* stfunc, const char name[], int type){
    int count;
    for (count = 0; count < stfunc->STsize; count++) {
        if (!strcmp(stfunc->symbolTable[count].name, name)) {
            printf("semantic error, redefinition of variable %s near line %d\n",
            name, lineno);
            return;
        }
    }
    if (++(stfunc->STsize) > STmax) {
        printf("too many variables near line %d\n", lineno);
        exit(1);
    }
    strcpy(stfunc->symbolTable[stfunc->STsize - 1].name, name);
    stfunc->symbolTable[stfunc->STsize-1].type = type;
}

void addVar(const char *funcName, const char name[], int type){
	int count;
    for (count = 0; count < STfuncSize; count++) {
        if (!strcmp(STFunctions[count].name, funcName)) {
			addVarAux(&(STFunctions[count]), name, type);
			return;
        }
    }
}

void addFunc(const char name[]){
    int count;
    for (count = 0; count < STfuncSize; count++) {
        if (!strcmp(STFunctions[count].name, name)) {
            printf("semantic error, redefinition of function %s near line %d\n",
            name, lineno);
            return;
        }
    }
    if (++STfuncSize > MAXFUNCS) {
        printf("too many variables near line %d\n", lineno);
        exit(1);
    }
    strcpy(STFunctions[STfuncSize - 1].name, name);
}

void printTable(){
	int i, j;
	for(i = 0; i < STfuncSize; i++){
		printf("%s\n", STFunctions[i].name);
		for(j = 0; j < STFunctions[i].STsize; j++){
			if(STFunctions[i].symbolTable[i].type == 0)
				printf("simple type %s\n", STFunctions[i].symbolTable[j].name);
			else
				printf("struct %s\n", STFunctions[i].symbolTable[j].name);
		}
	}
}

int alreadyIn(char *funcName, char* ident){
	int i, j;
	for(i = 0; i < STfuncSize; i++){
		if(!strcmp(STFunctions[i].name, funcName))
			break;
	}
	if(i >= STfuncSize)
		return 0;
	for(j = 0; j < STFunctions[i].STsize; j++){
		if(strcmp(ident, STFunctions[i].symbolTable[j].name) == 0){
			printf("%s est déjà présent dans la table des symboles\n", ident);
			return 1;
		}
	}
	return 0;
}
