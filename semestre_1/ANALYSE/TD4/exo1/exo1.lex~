%{
    #include "exo1.tab.h"
    int lineno = 1;
    int caractereno = 1;
%}

%option noyywrap
%option nounput
%option noinput

%x COMMENT STRING DSCOMMENT

%%

"int"|"double"|"float"|"short"|"char" return TYPE;

void return VOID;

\" 			{BEGIN STRING; }
"/*"                    {BEGIN COMMENT;}
"//"			{caractereno += yyleng; BEGIN DSCOMMENT;}
<DSCOMMENT>.		{caractereno += yyleng;}
<DSCOMMENT>\n		{caractereno = 0; lineno++; BEGIN INITIAL; }
<COMMENT,STRING>.       {caractereno += yyleng;} 
<COMMENT,STRING>\n      {caractereno = 0; lineno++;}
<STRING>["]		{caractereno += yyleng; BEGIN INITIAL; }
<COMMENT>"*/"           {caractereno += yyleng; BEGIN INITIAL; }
"&&"                    {caractereno += yyleng; return AND;}
"||"                    {caractereno += yyleng; return OR;}
return                  {caractereno += yyleng; return RETURN;}
if                      {caractereno += yyleng; return IF;}
else                    {caractereno += yyleng; return ELSE;}
while                   {caractereno += yyleng; return WHILE;}
printf                  {caractereno += yyleng; return PRINT;}
reade                   {caractereno += yyleng; return READE;}
readc                   {caractereno += yyleng; return READC;}
[0-9]+                  {caractereno += yyleng; return NUM;}
==                      {caractereno += yyleng; return EQ;}
[+-]                    {caractereno += yyleng; return ADDSUB;}
[*/%]                   {caractereno += yyleng; return DIVSTAR;}
[a-zA-Z][a-zA-Z0-9_]*   {caractereno += yyleng; return IDENT;}
[<]=?|[>]=?             {caractereno += yyleng; return ORDER;}
\n                      {caractereno = 0; lineno++;}
<<EOF>>                 {return 0;}
\'.\'                   {caractereno += yyleng; return CHARACTER;}
.                       {caractereno += yyleng; return yytext[0];}

%%
