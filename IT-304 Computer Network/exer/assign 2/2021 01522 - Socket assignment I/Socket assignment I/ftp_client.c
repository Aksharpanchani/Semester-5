#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include <fcntl.h>
#include <arpa/inet.h> // Include this for inet_addr

#define PORT 8010
#define BUFSIZE 1024

void receive_file(int server_socket, const char* filename) {
    int fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR);
    if (fd == -1) {
        perror("Error creating file");
        return;
    }

    char buffer[BUFSIZE];
    int bytes_received;

    while ((bytes_received = recv(server_socket, buffer, BUFSIZE, 0)) > 0) {
        write(fd, buffer, bytes_received);
    }

    close(fd);
}

int main(int argc, char* argv[]) {
    if (argc != 4) {
        printf("Usage: %s <server_ip> <command(GET/PUT/LIST)> <filename>\n", argv[0]);
        exit(1);
    }

    int client_socket;
    struct sockaddr_in server_addr;

    client_socket = socket(AF_INET, SOCK_STREAM, 0);
    if (client_socket < 0) {
        perror("Error creating socket");
        exit(1);
    }

    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(PORT);
    server_addr.sin_addr.s_addr = inet_addr(argv[1]);

    if (connect(client_socket, (struct sockaddr*)&server_addr, sizeof(server_addr)) < 0) {
        perror("Error connecting to server");
        exit(1);
    }

    char command[BUFSIZE];
    snprintf(command, BUFSIZE, "%s %s", argv[2], argv[3]);
    send(client_socket, command, strlen(command), 0);

    if (strncmp(argv[2], "GET", 3) == 0) {
        receive_file(client_socket, argv[3]);
        printf("File received successfully.\n");
    } else if (strncmp(argv[2], "PUT", 3) == 0) {
        // Implement PUT operation if needed.
    } else if (strncmp(argv[2], "LIST", 4) == 0) {
        // Implement LIST operation if needed.
    }

    close(client_socket);
    return 0;
}

