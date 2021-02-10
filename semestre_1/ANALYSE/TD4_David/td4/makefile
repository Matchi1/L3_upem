EXEC=exo1

$(EXEC): $(EXEC).tab.o lex.yy.o
	gcc -o $(EXEC) -lfl  $^

$(EXEC).tab.o: $(EXEC).tab.c 
	gcc -Wall -c $<

$(EXEC).tab.c: $(EXEC).y
	bison -d $< 

lex.yy.o: lex.yy.c 
	gcc -Wall -c $<

lex.yy.c: $(EXEC).lex
	flex $<

clean:
	rm -f lex.yy.*
	rm -f exo1.tab.*
	rm -f $(EXEC)
