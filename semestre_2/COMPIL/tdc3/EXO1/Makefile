CC = nasm
LIBS = squelette.o utils.o
EXEC = squelette

$(EXEC): $(LIBS)
	gcc -o $@ $^ -nostartfiles -no-pie

$(EXEC).o: $(EXEC).asm

utils.o: utils.asm

%.o: %.asm
	$(CC) -f elf64 -o $@ $<

clean:
	rm -f *.o

mrproper: clean
	rm -f $(EXEC)

