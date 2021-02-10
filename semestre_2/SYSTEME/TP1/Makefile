CC = gcc
CFLAGS = -ansi -pedantic
EXECS = exo1 exo2 exo3 exo4 exo5

make:
	make exo1
	make exo2
	make exo3
	make exo4
	make exo5

exo1: exo1.c
	$(CC) -o $@ $< $(CFLAGS)

exo2: exo2.c
	$(CC) -o $@ $< $(CFLAGS)

exo3: exo3.c
	$(CC) -o $@ $< $(CFLAGS)

exo4: exo4.c
	$(CC) -o $@ $< $(CFLAGS)

exo5: exo5.c
	$(CC) -o $@ $< $(CFLAGS)

clean: 
	rm -rf *.o

mrproper: clean
	rm -rf $(EXECS)
