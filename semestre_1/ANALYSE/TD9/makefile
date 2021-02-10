# Makefile TP Flex

# $@ : the current target
# $^ : the current prerequisites
# $< : the first current prerequisite

CC=gcc
CFLAGS=-Wall
LDFLAGS=-Wall -lfl
EXEC=as

# all: $(EXEC) clean

$(EXEC): exp-tpc.tab.o lex.yy.o
	$(CC) -o $@ $^ $(LDFLAGS)

exp-tpc.tab.c: exp-tpc.y
	bison -d $<

lex.yy.c: $(EXEC).lex
	flex $(EXEC).lex

%.o: %.c
	$(CC) -o $@ -c $< $(CFLAGS)

clean:
	rm -f lex.yy.*
	rm -f $(EXEC).tab.*

mrproper: clean
	rm -f $(EXEC)
