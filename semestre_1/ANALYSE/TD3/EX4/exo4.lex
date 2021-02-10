%{
    #include "exo4.tab.h"
%}

%option noyywrap
%option nounput
%option noinput

%%
ou return OU;
et return ET;
non return NON;
vrai return VRAI;
faux return FAUX;
[(] return yytext[0];
[)] return yytext[0];
\n return 0;
.
%%