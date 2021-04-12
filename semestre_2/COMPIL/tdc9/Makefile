# Makefile TP Flex

# $@ : the current target
# $^ : the current prerequisites
# $< : the first current prerequisite

CC=gcc
CFLAGS=-Wall
LDFLAGS=-Wall -lfl
LEXER=lexer
PARSER=parser

all: $(LEXER) clean

$(LEXER): $(PARSER).tab.o lex.yy.o abstract-tree.o decl-var.o gen_nasm.o
	$(CC) -o $@ $^ $(LDFLAGS)

$(PARSER).tab.c: $(PARSER).y
	bison -d $<

lex.yy.c: $(LEXER).lex
	flex $<

decl-var.o: decl-var.c

abstract-tree.o: abstract-tree.c

gen_nasm.o: gen_nasm.c

%.o: %.c
	$(CC) -o $@ -c $< $(CFLAGS)

clean:
	rm -f lex.yy.*
	rm -f $(PARSER).tab.*
	rm -f *.o

mrproper: clean
	rm -f $(LEXER)
