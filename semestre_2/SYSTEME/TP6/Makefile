CC = gcc
CFLAGS = -Wall -pedantic
EXECS = exo1 exo2

make:
	make exo1
	make exo2

exo1: exo1.c
	gcc -o $@ $< $(CFLAGS)

exo2: exo2.c
	gcc -o $@ $< $(CFLAGS)

clean:
	rm -f *.o

mrproper:
	rm -f $(EXECS)
