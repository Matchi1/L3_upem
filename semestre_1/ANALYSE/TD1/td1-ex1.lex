%{
/* td1-ex1.lex */
int line_count_eng = 0;
int compte_ligne_fr = 0;
%}

%option nounput
%option noinput

%%
the    { 
		/* commentaire partie règle */
		line_count_eng++;
		}
of     line_count_eng++;
and    line_count_eng++;
to     line_count_eng++;
a      line_count_eng++;
his    line_count_eng++;
in     line_count_eng++;
with   line_count_eng++;
I      line_count_eng++;
which  line_count_eng++;
de   compte_ligne_fr++;
à    compte_ligne_fr++;
le   compte_ligne_fr++;
la   compte_ligne_fr++;
et   compte_ligne_fr++;
il   compte_ligne_fr++;
les  compte_ligne_fr++;
un   compte_ligne_fr++;
en   compte_ligne_fr++;
du   compte_ligne_fr++;
[a-zA-ZâàçêéèëîïôûùüœÂÀÇÊÉÈËÎÏÔÛÙÜŒ]+ ;
. ;
\n ;
<<EOF>> {
		if (line_count_eng == compte_ligne_fr) printf("Le texte est aussi français que anglais.\n");
		else {
			printf("Le texte est plus %s que %s.\n", 
			(line_count_eng > compte_ligne_fr ? "anglais" : "français"),
			(line_count_eng < compte_ligne_fr ? "anglais" : "français"));
		}
		return 0;
}		
%%

/* commentaires partie fonction C */