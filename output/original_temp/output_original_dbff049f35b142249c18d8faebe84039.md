**Minimum Rated Players with Rated Opponents**

### Problem Description

Host a chess tournament with `2 * N` people. `X` players are rated, and the rest are unrated. Pair players to minimize the number of rated players with rated opponents.

### Input Format

- The first line contains an integer `T`, the number of test cases.
- Each test case consists of a line with two space-separated integers `N` and `X`.

### Output Format

- For each test case, print the minimum number of rated players with rated opponents.

### Constraints

- `1 ≤ N ≤ 50`
- `0 ≤ X ≤ 2 * N`

### Sample Test Cases

| Test Case | Input | Output |
| --- | --- | --- |
| 1    | 1 0 | 0    |
| 2    | 1 1 | 0    |
| 3    | 1 2 | 2    |
| 4    | 4 4 | 4    |
| 5    | 4 6 | 4    |
| 6    | 10 20 | 20 |

### C Program

```c
#include <stdio.h>

int main() {
    int t;
    scanf("%d", &t);

    while (t--) {
        int n, x;
        scanf("%d %d", &n, &x);

        // Calculate the number of unrated players
        int unrated_players = 2 * n - x;

        // Calculate the minimum number of rated players with rated opponents
        int min_rated_players = (x % 2 == 0) ? x / 2 : (x + 1) / 2;

        printf("%d\n", min_rated_players);
    }

    return 0;
}
```

### Explanation

1.  **Read the Number of Test Cases**: The program starts by reading the number of test cases `t`.
2.  **Loop Through Each Test Case**: It then enters a loop that runs `t` times.
3.  **Read `N` and `X`**: Inside the loop, it reads two integers `n` and `x`, representing the total number of players and the number of rated players, respectively.
4.  **Calculate the Number of Unrated Players**: The number of unrated players is calculated by subtracting `x` from `2 * n`.
5.  **Calculate the Minimum Number of Rated Players with Rated Opponents**: The minimum number of rated players with rated opponents is determined based on whether `x` is even or odd. If `x` is even, it's simply `x / 2`. If `x` is odd, it's `(x + 1) / 2`.
6.  **Print the Result**: Finally, the program prints the calculated minimum number of rated players with rated opponents for each test case.

This C program efficiently solves the problem by handling both even and odd values of `x` and providing the correct minimum number of rated players with rated opponents for each test case.