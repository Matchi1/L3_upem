%{
    #include "exo2.tab.h"
	int lineno = 0;
%}

%option noyywrap
%option nounput
%option noinput

%%
[ab] 	{ return (yytext[0] == 'a' ? CHARACTERA : CHARACTERB); }
\n 		{ lineno++; }
.		return yytext[0];
%%
