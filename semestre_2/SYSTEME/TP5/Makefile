CC = gcc
CFLAGS = -Wall -pedantic
EXECS = exo1 exo2

make:
	make exo1
	make exo5

exo1: exo1.c
	gcc -o $@ $< $(CFLAGS)

exo5: exo5.c add.c sub.c div.c mul.c
	gcc -o $@ $< $(CFLAGS)
	gcc -o add add.c $(CFLAGS)
	gcc -o sub sub.c $(CFLAGS)
	gcc -o div div.c $(CFLAGS)
	gcc -o mul mul.c $(CFLAGS)

clean:
	rm -f *.o

mrproper:
	rm -f $(EXECS)
