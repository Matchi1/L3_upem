/* decl-var.h */
/* Analyse descendante récursive des déclarations de variables en C */
#ifndef __STENTRY__
#define __STENTRY__
#define MAXNAME 32
#define MAXSYMBOLS 256

typedef struct {
    char name[MAXNAME];
    int type;
} STentry;

typedef struct {
	char name[MAXNAME];
	int STsize;
	STentry symbolTable[MAXSYMBOLS];
} STfunc;

void check(int token);
void addVar(const char *funcName, const char name[], int type);
void addFunc(const char name[]);
void syntaxError();
void printTable();
int alreadyIn(char *funcName, char* ident);

#endif 
