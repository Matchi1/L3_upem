/* decl-var.h */
/* Analyse descendante récursive des déclarations de variables en C */
#define MAXNAME 32
typedef struct {
    char name[MAXNAME];
    int type;
} STentry;
#define INTEGER 0
#define REAL 1

void check(int token);
void addVar(const char name[], int type);
void syntaxError();
