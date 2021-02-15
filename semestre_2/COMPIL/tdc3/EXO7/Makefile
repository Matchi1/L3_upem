CC = nasm
LIBS = utils.o little_endian.o
EXEC = little_endian

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

