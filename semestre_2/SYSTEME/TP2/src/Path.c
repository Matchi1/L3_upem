#include <stdio.h>
#include <string.h>
#include "../include/Path.h"

/**
 * Initialize a Path structure.
 * @param p a pointor to a Path structure.
 * @param file_name the name of a file.
 */
void init_path(Path* p, const char* file_name){
	strcpy(p->path, file_name);
	p->length = strlen(file_name);
}

/**
 * Append a file name into the specified path.
 * @param p a pointor to the specified Path structure.
 * @param file_name the name of a file.
 * @return the previous length of the specfied path.
 */
int append(Path* p, const char* file_name){
	char old_path[MAX_LENGTH];
	int old_length = p->length;

	strcpy(old_path, p->path);
	snprintf(p->path, MAX_LENGTH, "%s%s%s", old_path, "/", file_name);
	p->length += strlen(file_name) + 1;
	return old_length;
}

/**
 * Reset the specified path to its previous length.
 * @param p a pointor to the specified PAth structure.
 * @param old_length the previous length of the path.
 */
void reset(Path* p, int old_length){
	p->path[old_length] = '\0';
	p->length = old_length;
}
