%{
/* Exo1.lex */
#include "exo1.tab.h"
int lineno = 1; 
%}

%option nounput
%option noinput
%option noyywrap
%x LCOM
%x SCOM

%%
<SCOM,LCOM,INITIAL><<EOF>>			{return 0;}
\n 									{lineno++;}
"/*"								{BEGIN LCOM;}
"//"								{BEGIN SCOM;}
<LCOM>"*/"							{BEGIN INITIAL;}
<SCOM,LCOM>.* 						{;}
<SCOM>\n 							{lineno++; BEGIN INITIAL;}
void 								{return VOID;}
if 									{return IF;}
while								{return WHILE;}
return 								{return RETURN;}
else								{return ELSE;}
-?[0-9]+							{return NUM;}
"/"|"*"|%							{return DIVSTAR;}
"+"|"-"								{return ADDSUB;}
[><]=?								{return ORDER;}
"=="|"!="							{return EQ;}
"&&"								{return AND;}
"||"								{return OR;}
\'.\'								{return CHARACTER;}
printf								{return PRINT;}
reade								{return READE;}
readc								{return READC;}
" "|\t 								;
int|char|double|float 				{return TYPE;}
[a-zA-Z][a-zA-Z0-9_]*				{return IDENT;}
. 									{return yytext[0];}
%%
