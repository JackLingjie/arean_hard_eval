**Handling `EINTR` Signals in Read Operations**

When performing a read operation on a file descriptor, it's possible for the system to interrupt the read due to a signal. This can occur when a signal is delivered to the process while it's waiting for data to be read.

### Example Code

Here's an example of how to handle `EINTR` signals in a read operation:

```c
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <signal.h>
#include <unistd.h>

// Function to handle the signal
void sigint_handler(int sig) {
    // Handle the signal here
    printf("Signal %d caught\n", sig);
}

int main() {
    // Initialize the signal handler
    struct sigaction sa;
    sa.sa_handler = sigint_handler;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = SA_RESTART;
    if (sigaction(SIGINT, &sa, NULL) == -1) {
        perror("sigaction");
        exit(EXIT_FAILURE);
    }

    // Open a file for reading
    FILE *fp = fopen("example.txt", "r");
    if (!fp) {
        perror("fopen");
        exit(EXIT_FAILURE);
    }

    char buffer[1024];

    // Perform a read operation
    while (1) {
        ssize_t bytes_read = fread(buffer, 1, sizeof(buffer), fp);
        if (bytes_read == -1) {
            if (errno == EINTR) {
                // Handle EINTR signal
                continue;
            } else {
                perror("fread");
                break;
            }
        } else if (bytes_read == 0) {
            // End of file reached
            break;
        }

        // Process the read data
        printf("%s", buffer);
    }

    fclose(fp);
    return 0;
}
```

### Key Points

-   **Signal Handling**: The `sigint_handler` function is set up to handle the `SIGINT` signal. This allows the program to catch and handle the signal when it's delivered.
-   **`SA_RESTART` Flag**: The `SA_RESTART` flag is used when setting up the signal handler. This flag causes interrupted system calls to be automatically restarted.
-   **`EINTR` Handling**: In the `main` function, the `fread` call is checked for the `EINTR` error. If `EINTR` is encountered, the loop continues to the next iteration, effectively restarting the read operation.
-   **Error Handling**: The program also handles other potential errors that may occur during the read operation, such as file opening errors or end-of-file conditions.

This example demonstrates how to handle `EINTR` signals in a read operation, ensuring that the program remains robust and continues executing even when interrupted by signals.