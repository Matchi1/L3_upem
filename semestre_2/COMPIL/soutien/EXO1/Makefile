CC = nasm
LIBS = utils.o 
EXEC = exo1

exo1: $(LIBS) exo1.o
	gcc -o $@ $^ -nostartfiles -no-pie

exo1.o: exo1.asm
	$(CC) -f elf64 -o $@ $<

utils.o: utils.asm
	$(CC) -f elf64 -o $@ $<
	
clean:
	rm -f *.o

mrproper: clean
	rm -f $(EXEC)

