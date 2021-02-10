#include <stdio.h>
#include <string.h>
#include "../include/Path.h"

void init_path(Path* p, const char* file_name){
	strcpy(p->path, file_name);
	p->length = strlen(file_name);
}

int append(Path* p, const char* file_name){
	int old_length = path->length;
	snprintf(p->path, MAX_LENGTH, "%s%s%s", p->path, "/", file_name);
	p->length += strlen(file_name) + 1;
	return old_length;
}

void reset(Path* p, int old_length){
	p->path[old_length] = '\0';
	p->length = old_length;
}
