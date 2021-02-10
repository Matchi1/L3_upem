%{
    #include <stdio.h>
    int yylex();
    int yyerror(char* s);
%}

%%
S   : 'a'S
    | S'a'
    | 'a''a'S
    | 'a'S'a'
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