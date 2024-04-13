#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include <dirent.h>

#define PORT 8010
#define BUFSIZE 1024

void send_file(int client_socket, const char* filename) {
    FILE* file = fopen(filename, "rb");
    if (file == NULL) {
        perror("Error opening file");
        return;
    }

    char buffer[BUFSIZE];
    size_t bytesRead;

    while ((bytesRead = fread(buffer, 1, BUFSIZE, file)) > 0) {
        send(client_socket, buffer, bytesRead, 0);
    }

    fclose(file);
}

void list_files(int client_socket) {
    DIR* dir;
    struct dirent* entry;

    dir = opendir(".");
    if (dir == NULL) {
        perror("Error opening directory");
        return;
    }

    while ((entry = readdir(dir)) != NULL) {
        send(client_socket, entry->d_name, strlen(entry->d_name), 0);
        send(client_socket, "\n", 1, 0);
    }

    closedir(dir);
}

int main() {
    int server_socket, client_socket;
    struct sockaddr_in server_addr, client_addr;
    socklen_t client_len = sizeof(client_addr);

    server_socket = socket(AF_INET, SOCK_STREAM, 0);
    if (server_socket < 0) {
        perror("Error creating socket");
        exit(1);
    }

    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(PORT);
    server_addr.sin_addr.s_addr = INADDR_ANY;

    if (bind(server_socket, (struct sockaddr*)&server_addr, sizeof(server_addr)) < 0) {
        perror("Error binding");
        exit(1);
    }

    listen(server_socket, 5);
    printf("FTP Server listening on port %d\n", PORT);

    while (1) {
        client_socket = accept(server_socket, (struct sockaddr*)&client_addr, &client_len);
        if (client_socket < 0) {
            perror("Error accepting connection");
            continue;
        }

        char command[BUFSIZE];
        recv(client_socket, command, BUFSIZE, 0);

        if (strncmp(command, "GET", 3) == 0) {
            char filename[BUFSIZE];
            sscanf(command, "GET %s", filename);
            send_file(client_socket, filename);
        } else if (strncmp(command, "PUT", 3) == 0) {
            // Implement PUT operation if needed.
        } else if (strncmp(command, "LIST", 4) == 0) {
            list_files(client_socket);
        }

        close(client_socket);
    }

    close(server_socket);
    return 0;
}

