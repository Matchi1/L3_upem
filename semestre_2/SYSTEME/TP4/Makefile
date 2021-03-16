CC = gcc
CFLAGS = -Wall -pedantic
EXECS = exo1 exo2 exo3 exo4 exo5 exo6

make:
	make exo1
	make exo2
	make exo3
	make exo4
	make exo5
	make exo6

exo1: exo1.c
	gcc -o $@ $< $(CFLAGS)

exo2: exo2.c
	gcc -o $@ $< $(CFLAGS)

exo3: exo3.c
	gcc -o $@ $< $(CFLAGS)
	
exo4: exo4.c
	gcc -o $@ $< $(CFLAGS)

exo5: exo5.c
	gcc -o $@ $< $(CFLAGS)

exo6: exo6.c
	gcc -o $@ $< $(CFLAGS)

clean:
	rm -f *.o

mrproper:
	rm -f $(EXECS)
