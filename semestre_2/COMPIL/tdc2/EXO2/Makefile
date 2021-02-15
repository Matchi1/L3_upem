# Makefile TP Flex

# $@ : the current target
# $^ : the current prerequisites
# $< : the first current prerequisite

CC=gcc
CFLAGS=-Wall
LDFLAGS=-Wall -lfl
EXEC=decl-var

# all: $(EXEC) clean

$(EXEC): $(EXEC).tab.o lex.yy.o decl-var.o
	$(CC) -o $@ $^ $(LDFLAGS)

$(EXEC).tab.c: $(EXEC).y
	bison -d $(EXEC).y

lex.yy.c: $(EXEC).lex
	flex $(EXEC).lex

decl-var.o: decl-var.c

%.o: %.c
	$(CC) -o $@ -c $< $(CFLAGS)

clean:
	rm -f lex.yy.*
	rm -f $(EXEC).tab.*

mrproper: clean
	rm -f $(EXEC)
