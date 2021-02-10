%{
	
%}

%option nounput
%option noinput

%%
"/*".*|\n*"*/" ;
"//".* ;
\"[^"]*\" ;
[a-zA-Z_][a-zA-Z_0-9]*/[ \n\t]*\( {ECHO; printf(" ");}
. ;
\n ;
<<EOF>> {
	printf("\n");
	return 0;
}
%%