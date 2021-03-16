# Makefile TP Flex

# $@ : the current target
# $^ : the current prerequisites
# $< : the first current prerequisite

CC=gcc
CFLAGS=-Wall
LDFLAGS=-Wall -lfl
EXEC=exo2

# all: $(EXEC) clean

$(EXEC): $(EXEC).tab.o lex.yy.o abstract-tree.o
	$(CC) -o $@ $^ $(LDFLAGS)

$(EXEC).tab.c: $(EXEC).y
	bison -d $(EXEC).y

lex.yy.c: $(EXEC).lex
	flex $(EXEC).lex

abstract-tree.o: abstract-tree.c

%.o: %.c
	$(CC) -o $@ -c $< $(CFLAGS)

clean:
	rm -f lex.yy.*
	rm -f $(EXEC).tab.*
	rm -f *.o

mrproper: clean
	rm -f $(EXEC)
