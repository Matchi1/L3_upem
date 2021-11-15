#include <stdio.h>
#include <stdlib.h>
#include <netdb.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>

void try(char* name, int ret_value){
	if(ret_value == -1){
		perror(name);
		exit(EXIT_FAILURE);
	}
}

void web(){
	int s;
	struct addrinfo hints, *res;

	memset(&hints, 0, sizeof hints);
	hints.ai_family = AF_INET;  	 // use IPv4 or IPv6, whichever
	hints.ai_socktype = SOCK_STREAM;
	hints.ai_flags = AI_PASSIVE;     // fill in my IP for me

	try("getaddrinfo", getaddrinfo("www.google.fr", "http", &hints, &res));
	try("socket", s = socket(res->ai_family, res->ai_socktype, res->ai_protocol));
	try("connect", connect(s, res->ai_addr, res->ai_addrlen));
	try("write", write(s, "Hello World\n", 12));
	close(s);
	freeaddrinfo(res);
}

void local(){
	int s;
	struct addrinfo hints, *res;

	memset(&hints, 0, sizeof hints);
	hints.ai_family = AF_INET;  	 // use IPv4 or IPv6, whichever
	hints.ai_socktype = SOCK_STREAM;
	hints.ai_flags = AI_PASSIVE;     // fill in my IP for me

	try("getaddrinfo", getaddrinfo("localhost", "1024", &hints, &res));
	try("socket", s = socket(res->ai_family, res->ai_socktype, res->ai_protocol));
	try("connect", connect(s, res->ai_addr, res->ai_addrlen));
	try("write", write(s, "GET / HTTP/1.1 www.google.fr\n", 29));
	close(s);
	freeaddrinfo(res);
}

int main(int argc, const char *argv[]){
	web();
	return 0;
}
