CC = gcc
CFLAGS = -Wall -pedantic
EXECS = repeat listen

make:
	make repeat
	make listen

repeat: repeat.c
	gcc -o $@ $< $(CFLAGS)

listen: listen.c
	gcc -o $@ $< $(CFLAGS)

clean:
	rm -f *.o

mrproper:
	rm -f $(EXECS)
