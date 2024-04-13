
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <string.h>
#include <fcntl.h>
#include <stdio.h>
#include<stdlib.h>

#define FNAME file1
#define PORT 8010
#define BUFSIZE 128
#define LISTENQ 5

int main(int argc, char **argv)
{
	int	listenfd, connfd, fd, pid, n, size;
	struct sockaddr_in servaddr;
	char buf[BUFSIZE],fname[50];

	struct stat stat_buf; 	
	

	listenfd = socket(AF_INET, SOCK_STREAM, 0);

	bzero(&servaddr, sizeof(servaddr));
	servaddr.sin_family      = AF_INET;
	servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
	servaddr.sin_port        = htons(PORT);	

	bind(listenfd, (struct sockaddr *) &servaddr, sizeof(servaddr));

	listen(listenfd, LISTENQ);
		printf("listening\n");

	for ( ; ; ) 
	{
		connfd = accept(listenfd, (struct sockaddr *) NULL, NULL);
		printf("Handling connection request\n");
		recv(connfd,fname,50,0);
		printf("Name of file being received is : %s", fname);  


		
		fd=open("new_file",O_WRONLY|O_CREAT,S_IRWXU);		
		
		printf("\nopened file\n");
		while ( (n = read(connfd, buf, BUFSIZE-1)) > 0) 
		{
			buf[n] = '\0';
			printf("%s\n",buf);
			write(connfd,buf,n);
		}
		printf("file receiving completed \n");
		
		close(connfd);
		close(fd);
		exit(1);
	}
}

