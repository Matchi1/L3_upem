# Makefile TP Flex

# $@ : the current target
# $^ : the current prerequisites
# $< : the first current prerequisite

CC=gcc
CFLAGS=-Wall
LDFLAGS=-Wall -lfl
EXEC=as

# all: $(EXEC) clean

$(EXEC): instr-tpc.tab.o lex.yy.o
	$(CC) -o $@ $^ $(LDFLAGS)

instr-tpc.tab.c: instr-tpc.y
	bison -d $<

lex.yy.c: $(EXEC).lex
	flex $(EXEC).lex

%.o: %.c
	$(CC) -o $@ -c $< $(CFLAGS)

clean:
	rm -f lex.yy.*
	rm -f instr-tpc.tab.*

mrproper: clean
	rm -f $(EXEC)

table:
	bison -r all instr-tpc.y
