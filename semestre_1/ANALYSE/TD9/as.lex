%{
	/*Projet.lex*/
	#include <stdio.h>
	#include "exp-tpc.tab.h"

	char text_line[100];
	int index_text = 0;
	int line = 1;
	int column = 0;

	#undef YY_INPUT
	#define YY_INPUT(buf, result, max_size){ \
		int c = getchar(); \
		if(c == '\n') \
			index_text = 0; \
		else { \
			text_line[index_text] = c; \
			index_text++; \
			text_line[index_text] = '\0'; \
		} \
		result = (c == EOF) ? YY_NULL : (buf[0] = c, 1); \
	}
%}

%option noyywrap
%option nounput
%option noinput

%x COMMENT OLCOMMENT STRING

%%
\/\* 						{column += yyleng; BEGIN COMMENT;}
\/\/ 						{column += yyleng; BEGIN OLCOMMENT;}
\" 							{column ++; BEGIN STRING;}

<COMMENT>"*/" 				{column += yyleng; BEGIN INITIAL;}
<OLCOMMENT>\n 				{column = 0; line++; BEGIN INITIAL;}
<STRING>\" 					{column++; BEGIN INITIAL;}
<STRING>\\\n 				{column += yyleng;}
<STRING>\\\" 				{column += yyleng;}
<OLCOMMENT,COMMENT>"\n" 	{line++; column = 0;}
<OLCOMMENT,COMMENT,STRING>. {column++;}

[ \t]+ 						{column += yyleng;}
== 							{column += yyleng; strcpy(yylval.comp, yytext); return EQ;}
&& 							{column += yyleng; strcpy(yylval.comp, yytext); return AND;}
\|\| 						{column += yyleng; return OR;}
\*|\/|% 					{column++; sscanf(yytext, "%c", &(yylval.byte)); return DIVSTAR;}
\+|- 						{column++; sscanf(yytext, "%c", &(yylval.byte)); return ADDSUB;}
"<""="?|">""="? 			{column += yyleng; strcpy(yylval.comp, yytext); return ORDER;}

[0-9]+ 						{column += yyleng; sscanf(yytext, "%d", &(yylval.num)); return NUM;}
[a-zA-Z_][a-zA-Z0-9_]* 		{column += yyleng; strcpy(yylval.ident, yytext); return IDENT;}

[a-zA-Z]					{column ++; sscanf(yytext, "%c", &(yylval.byte)); return CHARACTER;}
. 							{column++; return yytext[0];}

\n 							{line++; column = 0; }
<<EOF>>						{return 0;}
%%
