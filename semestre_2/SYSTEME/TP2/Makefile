CC = gcc
CFLAGS = -pedantic -Wall -ansi -D_DEFAULT_SOURCE 
SRC_PATH = src/
INCLUDE_PATH = include/
BIN_PATH = bin/
LDLIBS = Main.o Option.o Display.o Path.o
LDLIBS_PATH = $(addprefix $(BIN_PATH),$(LDLIBS))
EXEC = myls

vpath %.o bin
vpath %.c src
vpath %.h include

$(EXEC): $(LDLIBS)
	$(CC) -o $@ $(LDLIBS_PATH) $(CFLAGS) $(LDFLAGS)

Main.o: Main.c 
	$(CC) -o $(BIN_PATH)$@ -c $< $(CFLAGS)

Option.o: Option.c 
	$(CC) -o $(BIN_PATH)$@ -c $< $(CFLAGS)

Display.o: Display.c 
	$(CC) -o $(BIN_PATH)$@ -c $< $(CFLAGS)

Path.o: Path.c 
	$(CC) -o $(BIN_PATH)$@ -c $< $(CFLAGS)

clean:
	find $(BIN_PATH)* -delete

mrproper: clean
	rm -f $(EXEC)
