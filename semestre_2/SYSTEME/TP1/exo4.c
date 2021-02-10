#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

/**
 * Test if a file has been modified during the execution
 * of this program
 * @param name the of the file
 */
void modification(const char* name){
	struct stat s;
	long time = 0;
	for(;;){
		if(stat(name, &s) == -1){
			perror("stat");
			exit(EXIT_FAILURE);
		}
		if(time == 0)
			time = s.st_mtime;
		if(time != s.st_mtime){
			printf("Le fichier a été modifié\n");
			exit(EXIT_SUCCESS);
		}
		sleep(2);
	}
}

int main(int argc, const char* argv[]){
	if(argc < 2){
		fprintf(stderr, "Usage: %s <pathname>\n", argv[0]);
		return 1;
	} else
		modification(argv[1]);
	return 0;
}
