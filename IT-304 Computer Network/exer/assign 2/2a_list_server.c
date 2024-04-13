
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
//	FILE *fp;
	struct sockaddr_in servaddr;
	char buf[BUFSIZE],fname[50];
	char cmd[100];

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
		printf("Feature requested by Client : %s \n", fname);  
		
		strcpy(cmd,"ls > list_output");
		system(cmd);
		
		fd=open("list_output",O_RDONLY,S_IRUSR);
		fstat(fd, &stat_buf);
		size = stat_buf.st_size;
		while ( (n = read(fd, buf, BUFSIZE-1)) > 0) 
		{
			buf[n] = '\0';
			printf("%s\n",buf);
			write(connfd,buf,n);
		}
		close(connfd);
		close(fd);
		exit(1);
	}
}

