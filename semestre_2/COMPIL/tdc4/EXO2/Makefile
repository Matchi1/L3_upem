CC = nasm
LIBS = utils.o 
EXEC = exo1

make:
	make exo1
	make exo1_2
	make exo1_3
	make exo1_4
	make exo1_5

exo1: $(LIBS) exo1.o
	gcc -o $@ $^ -nostartfiles -no-pie

exo1_2: $(LIBS) exo1_2.o
	gcc -o $@ $^ -nostartfiles -no-pie

exo1_3: $(LIBS) exo1_3.o
	gcc -o $@ $^ -nostartfiles -no-pie

exo1_4: $(LIBS) exo1_4.o
	gcc -o $@ $^ -nostartfiles -no-pie

exo1_5: $(LIBS) exo1_5.o
	gcc -o $@ $^ -nostartfiles -no-pie

exo1.o: exo1.asm
	$(CC) -f elf64 -o $@ $<

exo1_2.o: exo1_2.asm
	$(CC) -f elf64 -o $@ $<

exo1_3.o: exo1_3.asm
	$(CC) -f elf64 -o $@ $<

exo1_4.o: exo1_4.asm
	$(CC) -f elf64 -o $@ $<

exo1_5.o: exo1_5.asm
	$(CC) -f elf64 -o $@ $<

utils.o: utils.asm
	$(CC) -f elf64 -o $@ $<
	
clean:
	rm -f *.o

mrproper: clean
	rm -f $(EXEC)

