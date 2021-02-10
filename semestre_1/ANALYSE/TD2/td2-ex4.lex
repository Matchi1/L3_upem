%{

%}

%option nounput
%option noinput
%x LETTRE UNION ESPACE

%%
[a-zA-Z] {ECHO; BEGIN LETTRE; }
-\n {BEGIN UNION; }
[ ]

<LETTRE>-[ ]*\n {BEGIN UNION; }
<LETTRE>[ ]- {ECHO; }

<UNION>[,;.:] {printf("%s\n", yytext); BEGIN INITIAL; }
<UNION>[ ] {ECHO; BEGIN ESPACE;}
<UNION>\n {ECHO; BEGIN INITIAL;}

<ESPACE>[,;.:]/[ ] {printf("%s\n", yytext); BEGIN INITIAL; }
<ESPACE>[a-zA-Z] {printf("\n%s", yytext); BEGIN INITIAL; }
%%