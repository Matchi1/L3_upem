#ifndef __PATH__
#define __PATH__

#define MAX_LENGTH 500

typedef struct {
	char path[MAX_LENGTH];
	int length;
} Path;

void init_path(Path* p, const char* file_name);

int append(Path* p, const char* file_name);

void reset(Path* p, int old_length);

#endif
