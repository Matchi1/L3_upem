# Makefile TP Flex

# $@ : the current target
# $^ : the current prerequisites
# $< : the first current prerequisite

CC = gcc
CFLAGS = -Wall
LDFLAGS = -Wall -lfl
EXEC = td2-ex1 td2-ex11 td2-ex3 td2-ex4 

# all: $(EXEC) clean

all:
	make td2-ex1
	make td2-ex11
	make td2-ex3
	make td2-ex4

td2-ex1: lex.yy.o
	$(CC) -o $@ $^ $(LDFLAGS)

td2-ex11: lex.yy.o
	$(CC) -o $@ $^ $(LDFLAGS)

td2-ex3: lex.yy.o
	$(CC) -o $@ $^ $(LDFLAGS)

td2-ex4: lex.yy.o
	$(CC) -o $@ $^ $(LDFLAGS)

lex1.yy.o: lex1.yy.c

lex11.yy.o: lex11.yy.c

lex3.yy.o: lex3.yy.c

lex4.yy.o: lex4.yy.c

lex1.yy.c: td2-ex1.lex
	  flex $< -o $@
lex.yy.c: td2-ex11.lex
	  flex $<

lex.yy.c: td2-ex3.lex
	  flex $<

lex.yy.c: td2-ex4.lex
	  flex $<

%.o: %.c
	$(CC) -o $@ -c $< $(CFLAGS)

clean:
	rm -f lex.yy.*
	rm -f $(EXEC)

