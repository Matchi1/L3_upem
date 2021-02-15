CC = nasm
LIBS = utils.o seg-donnees.o
EXEC = seg-donnees

$(EXEC): $(LIBS)
	gcc -o $@ $^ -nostartfiles -no-pie

$(EXEC).o: $(EXEC).asm
	$(CC) -f elf64 -o $@ $<

utils.o: utils.asm
	$(CC) -f elf64 -o $@ $<
	
clean:
	rm -f *.o

mrproper: clean
	rm -f $(EXEC)

