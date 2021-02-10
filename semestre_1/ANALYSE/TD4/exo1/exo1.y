%{
/* tpc-2020-2021.y */
/* Syntaxe du TPC pour le projet d'analyse syntaxique de 2020-2021*/
    #include <stdio.h>
    int yylex();
    int yyerror(char* s);
    extern int lineno;
%}

%token IDENT TYPE VOID OR AND EQ ORDER ADDSUB ELSE RETURN
%token DIVSTAR NUM READE READC PRINT IF WHILE CHARACTER

%%
Prog:  DeclVars DeclFoncts 
    ;
DeclVars:
       DeclVars TYPE Declarateurs ';' 
    |
    ;
Declarateurs:
       Declarateurs ',' IDENT 
    |  IDENT 
    ;
DeclFoncts:
       DeclFoncts DeclFonct 
    |  DeclFonct 
    ;
DeclFonct:
       EnTeteFonct Corps 
    ;
EnTeteFonct:
       TYPE IDENT '(' Parametres ')' 
    |  VOID IDENT '(' Parametres ')' 
    ;
Parametres:
       VOID 
    |  ListTypVar 
    ;
ListTypVar:
       ListTypVar ',' TYPE IDENT 
    |  TYPE IDENT 
    ;
Corps: '{' DeclVars SuiteInstr '}' 
    ;
SuiteInstr:
       SuiteInstr Instr 
    |
    ;
Instr:
       LValue '=' Exp ';'
    |  READE '(' IDENT ')' ';'
    |  READC '(' IDENT ')' ';'
    |  PRINT '(' Exp ')' ';'
    |  IF '(' Exp ')' Instr 
    |  IF '(' Exp ')' Instr ELSE Instr
    |  WHILE '(' Exp ')' Instr
    |  IDENT '(' Arguments  ')' ';'
    |  RETURN Exp ';' 
    |  RETURN ';' 
    |  '{' SuiteInstr '}' 
    |  ';' 
    ;
Exp :  Exp OR TB 
    |  TB 
    ;
TB  :  TB AND FB 
    |  FB 
    ;
FB  :  FB EQ M
    |  M
    ;
M   :  M ORDER E 
    |  E 
    ;
E   :  E ADDSUB T 
    |  T 
    ;    
T   :  T DIVSTAR F 
    |  F 
    ;
F   :  ADDSUB F 
    |  '!' F 
    |  '(' Exp ')' 
    |  NUM 
    |  CHARACTER
    |  LValue
    |  IDENT '(' Arguments  ')' 
    ;
LValue:
       IDENT 
    ;
Arguments:
       ListExp 
    |
    ;
ListExp:
       ListExp ',' Exp 
    |  Exp 
    ;
%%

int yyerror(char* s){
    fprintf(stderr, "ligne %d:%d : %s\n", lineno, caractereno, s);
    return 0;
}

int main(void){
    yyparse();
    return 0;
}
