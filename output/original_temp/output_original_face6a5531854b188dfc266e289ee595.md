**Fair Toy Distribution**

### Problem Description

A mother bought a set of `N` toys for her two kids, Alice and Bob. She has forgotten the monetary values of the toys but remembers that they were ordered in ascending order. The prices are non-negative.

A distribution is considered fair if the difference between the values of the toys Alice got and the toys Bob got does not exceed the maximum value of any toy.

### Code

```c
#include <stdio.h>
#include <string.h>

#define MAX_N 100

int main() {
    int t, n;
    char s[MAX_N];

    // Read the number of test cases
    scanf("%d", &t);

    while (t--) {
        // Read the number of toys and the distribution string
        scanf("%d %s", &n, s);

        // Initialize variables
        int max_diff = 0;
        int alice_sum = 0;
        int bob_sum = 0;

        // Iterate over the distribution string
        for (int i = 0; i < n; i++) {
            // Update the sums
            if (s[i] == '1') {
                alice_sum += 1;
            } else {
                bob_sum += 1;
            }

            // Update the maximum difference
            max_diff = (i < n - 1) ? max_diff : 0;
            if (s[i] == '1') {
                max_diff = (max_diff > alice_sum - bob_sum) ? max_diff : alice_sum - bob_sum;
            } else {
                max_diff = (max_diff > bob_sum - alice_sum) ? max_diff : bob_sum - alice_sum;
            }
        }

        // Check if the distribution is fair
        if (max_diff <= (s[n - 1] - '0')) {
            printf("YES\n");
        } else {
            printf("NO\n");
        }
    }

    return 0;
}
```

### Explanation

1.  Read the number of test cases.
2.  For each test case:
    *   Read the number of toys and the distribution string.
    *   Initialize variables to keep track of the maximum difference and the sums of toys for Alice and Bob.
    *   Iterate over the distribution string:
        *   Update the sums based on the current character.
        *   Update the maximum difference.
    *   Check if the distribution is fair by comparing the maximum difference with the maximum value of any toy.

### Example Use Cases

*   **Test Case 1**

    *   Input:

        ```
        1
        1
        1
        ```
    *   Output:

        ```
        YES
        ```
*   **Test Case 2**

    *   Input:

        ```
        2
        2
        00
        ```
    *   Output:

        ```
        NO
        ```
*   **Test Case 3**

    *   Input:

        ```
        4
        1010
        ```
    *   Output:

        ```
        YES
        ```
*   **Test Case 4**

    *   Input:

        ```
        4
        1100
        ```
    *   Output:

        ```
        NO
        ```
*   **Test Case 5**

    *   Input:

        ```
        6
        010101
        ```
    *   Output:

        ```
        YES
        ```
*   **Test Case 6**

    *   Input:

        ```
        5
        00001
        ```
    *   Output:

        ```
        NO
        ```