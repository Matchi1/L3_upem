%{
/* td1-ex4.lex */
%}

%option nounput
%option noinput

%%
[a-zA-ZâàçêéèëîïôûùüœÂÀÇÊÉÈËÎÏÔÛÙÜŒ]{0,4} ;
[a-zA-ZâàçêéèëîïôûùüœÂÀÇÊÉÈËÎÏÔÛÙÜŒ]{5,} ECHO;
%%
