CC = nasm
LIBS = utils.o 
EXEC = exo1 exo1_2

make:
	make exo1
	make exo1_2

exo1: $(LIBS) exo1.o
	gcc -o $@ $^ -nostartfiles -no-pie

exo1.o: exo1.asm
	$(CC) -f elf64 -o $@ $<

exo1_2: $(LIBS) exo1_2.o seg-donnees.o
	gcc -o $@ $^ -nostartfiles -no-pie

exo1_2.o: exo1_2.asm
	$(CC) -f elf64 -o $@ $<

utils.o: utils.asm
	$(CC) -f elf64 -o $@ $<

seg-donnees.o: seg-donnees.asm
	$(CC) -f elf64 -o $@ $<
	
clean:
	rm -f *.o

mrproper: clean
	rm -f $(EXEC)

