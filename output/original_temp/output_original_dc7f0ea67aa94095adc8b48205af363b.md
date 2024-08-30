**Reading Network Packets from a Socket in C++**

This example demonstrates how to read network packets from a socket listening on port 8888.

### Prerequisites

- **Socket Programming**: Familiarity with creating and managing sockets.
- **Network Communication**: Understanding of how data is transmitted over a network.

### Code

```cpp
#include <iostream>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>

// Function to handle errors
void handleError(const char* message) {
    perror(message);
    exit(EXIT_FAILURE);
}

int main() {
    // Create a socket
    int serverSocket = socket(AF_INET, SOCK_STREAM, 0);
    if (serverSocket == -1) {
        handleError("Failed to create socket");
    }

    // Define server address
    struct sockaddr_in serverAddress;
    serverAddress.sin_family = AF_INET;
    serverAddress.sin_port = htons(8888); // Port number
    inet_pton(AF_INET, "127.0.0.1", &serverAddress.sin_addr); // Localhost

    // Bind the socket to the address
    if (bind(serverSocket, (struct sockaddr*)&serverAddress, sizeof(serverAddress)) == -1) {
        handleError("Failed to bind socket");
    }

    // Listen for incoming connections
    if (listen(serverSocket, 3) == -1) { // Maximum 3 pending connections
        handleError("Failed to listen for connections");
    }

    std::cout << "Server listening on port 8888..." << std::endl;

    // Accept incoming connections
    struct sockaddr_in clientAddress;
    socklen_t clientAddressLength = sizeof(clientAddress);
    int clientSocket = accept(serverSocket, (struct sockaddr*)&clientAddress, &clientAddressLength);
    if (clientSocket == -1) {
        handleError("Failed to accept connection");
    }

    // Receive data from the client
    char buffer[256];
    int bytesReceived = recv(clientSocket, buffer, 256, 0);
    if (bytesReceived == -1) {
        handleError("Failed to receive data");
    }

    // Display received data
    std::cout << "Received data: " << buffer << std::endl;

    // Close the client socket
    close(clientSocket);

    // Close the server socket
    close(serverSocket);

    return 0;
}
```

### Explanation

1. **Create a Socket**: The `socket()` function creates a new socket.
2. **Define Server Address**: The server address is defined with `AF_INET` for IPv4 and `htons(8888)` for port 8888.
3. **Bind the Socket**: The `bind()` function associates the socket with the server address.
4. **Listen for Connections**: The `listen()` function enables the socket to accept incoming connections.
5. **Accept Incoming Connections**: The `accept()` function waits for an incoming connection and returns a new socket for communication.
6. **Receive Data**: The `recv()` function receives data from the client.
7. **Close Sockets**: Finally, close both the client and server sockets.

### Example Use Case

- **Server**: This code acts as a simple server listening on port 8888.
- **Client**: A client can connect to this server using a socket and send data. The server will receive and display the data.