#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>

#define PORT 8010
#define BUFSIZE 1024

void receive_file(int server_socket, const char* filename) {
    FILE* file = fopen(filename, "wb");
    if (file == NULL) {
        perror("Error opening file");
        return;
    }

    char buffer[BUFSIZE];
    size_t bytesRead;

    while ((bytesRead = recv(server_socket, buffer, BUFSIZE, 0)) > 0) {
        fwrite(buffer, 1, bytesRead, file);
    }

    fclose(file);
}

int main(int argc, char* argv[]) {
    if (argc != 4) {
        printf("Usage: %s <command(GET/PUT/LIST)> <filename>\n", argv[0]);
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
    //server_addr.sin_addr.s_addr = inet_addr("127.0.0.1"); // Set server IP to 127.0.0.1

    if (connect(client_socket, (struct sockaddr*)&server_addr, sizeof(server_addr)) < 0) {
        perror("Error connecting to server");
        exit(1);
    }

    char command[BUFSIZE];
    snprintf(command, BUFSIZE, "%s %s", argv[1], argv[2]);
    send(client_socket, command, strlen(command), 0);

    if (strncmp(argv[1], "GET", 3) == 0) {
        receive_file(client_socket, argv[2]);
        printf("File received successfully.\n");
    } else if (strncmp(argv[1], "PUT", 3) == 0) {
        // Implement PUT operation if needed.
    } else if (strncmp(argv[1], "LIST", 4) == 0) {
        char response[BUFSIZE];
        while (recv(client_socket, response, BUFSIZE, 0) > 0) {
            printf("%s", response);
        }
    }

    close(client_socket);
    return 0;
}

