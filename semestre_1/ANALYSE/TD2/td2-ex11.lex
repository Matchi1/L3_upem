%{
	#define MAXNAME 20
	char mot[MAXNAME];
%}

%option nounput
%option noinput
%x DQ SS SE FCT

%%
"/*" {BEGIN SE; }
"//" {BEGIN SS; }
\" {BEGIN DQ; }
[a-zA-Z_][a-zA-Z_0-9]* {strcpy(mot, yytext); BEGIN FCT; }
\( {printf("%s ", mot); }
.
\n

<SE>[^*/] 
<SE>"*/" {BEGIN INITIAL; }

<SS>.*
<SS>\n {BEGIN INITIAL; }

<DQ>[^"]
<DQ>\" {BEGIN INITIAL; }

<FCT>[ ] {BEGIN INITIAL; }
<FCT>\( {printf("%s ", mot); BEGIN INITIAL; }
<FCT>. {BEGIN INITIAL; }
%%