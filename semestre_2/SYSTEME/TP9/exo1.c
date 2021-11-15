#include <stdio.h>
#include <stdlib.h>
#include <netdb.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>

#define BACKLOG 10

void try(char* name, int ret_value){
	if(ret_value == -1){
		perror(name);
		exit(EXIT_FAILURE);
	}
}

void local(const char *port){
	struct sockaddr_storage their_addr;
	socklen_t addr_size;
	int s, err, new_fd;
	struct addrinfo hints, *res;

	memset(&hints, 0, sizeof hints);
	hints.ai_family = AF_INET;  	 // use IPv4 or IPv6, whichever
	hints.ai_socktype = SOCK_STREAM;
	hints.ai_flags = AI_PASSIVE;     // fill in my IP for me

	if((err = getaddrinfo("localhost", port, &hints, &res)) != 0){
		gai_strerror(err);
		exit(EXIT_FAILURE);
	}

	try("socket", s = socket(res->ai_family, res->ai_socktype, res->ai_protocol));
	try("bind", bind(s, res->ai_addr, res->ai_addrlen));
	freeaddrinfo(res);

	try("listen", listen(s, BACKLOG));
	addr_size = sizeof their_addr;
	while(1){
		new_fd = accept(s, NULL, NULL);
		try("accept", new_fd);
		write(new_fd, "bonjour\n", 8);
		close(new_fd);
	}
	close(s);
}

int main(int argc, const char *argv[]){
	local(argv[1]);
	return 0;
}
