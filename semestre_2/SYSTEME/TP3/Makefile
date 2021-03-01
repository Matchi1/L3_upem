CC = gcc
CFLAGS = -Wall -pedantic
EXECS = Mycat Mycp Redirection Reredirection

make:
	make Mycat
	make Mycp
	make Redirection
	make Reredirection

Mycat: Mycat.c
	gcc -o $@ $< $(CFLAGS)

Mycp: Mycp.c
	gcc -o $@ $< $(CFLAGS)

Redirection: Redirection.c
	gcc -o $@ $< $(CFLAGS)

Reredirection: Reredirection.c
	gcc -o $@ $< $(CFLAGS)

clean:
	rm -f *.o

mrproper:
	rm -f $(EXECS)
