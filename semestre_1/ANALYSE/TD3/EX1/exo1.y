%{
    #include <stdio.h>
    int yylex();
    int yyerror(char* s);
%}

%%
S   : 'a'S
    | 'b'
    ;
%%

int yyerror(char* s){
    fprintf(stderr, "%s\n", s);
    return 0;
}

int main(void){
    yyparse();
    return 0;
}