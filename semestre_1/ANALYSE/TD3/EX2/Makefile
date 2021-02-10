# Makefile TP Flex

# $@ : the current target
# $^ : the current prerequisites
# $< : the first current prerequisite

CC=gcc
CFLAGS=-Wall
LDFLAGS=-Wall -lfl
EXEC=exo2

# all: $(EXEC) clean

analyse: $(EXEC).tab.o lex.yy.o 
	$(CC) $^ -o $@

lex.yy.c: $(EXEC).lex
	flex $<

$(EXEC).tab.c: $(EXEC).y
	bison -d $< 

%.o: %.c
	$(CC) -o $@ -c $< $(CFLAGS)

clean:
	rm -f lex.yy.*
	rm -f analyse
