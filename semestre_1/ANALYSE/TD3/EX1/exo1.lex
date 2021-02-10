%{
    #include "exo1.tab.h"
%}

%option noyywrap
%option nounput
%option noinput

%%
[a-zA-Z] {return yytext[0]; }
\n {return 0; }
.
%%