# Makefile TP Flex

# $@ : the current target
# $^ : the current prerequisites
# $< : the first current prerequisite

CC=gcc
CFLAGS=-Wall
LDFLAGS=-Wall -lfl
EXEC=exo1

# all: $(EXEC) clean

$(EXEC): lex.yy.o decl-var.o
	$(CC) -o $@ $^ $(LDFLAGS)

lex.yy.o: lex.yy.c

lex.yy.c: decl-var.lex
	flex $<

decl-var.o: decl-var.c

%.o: %.c
	$(CC) -o $@ -c $< $(CFLAGS)

clean:
	rm -f lex.yy.*
	rm -f $(EXEC).tab.*
	rm -f *.o

mrproper: clean
	rm -f $(EXEC)
