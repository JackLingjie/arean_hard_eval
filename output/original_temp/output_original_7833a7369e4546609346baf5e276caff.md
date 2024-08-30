**Expected Number of Rounds to End the Game**

The problem describes a game where a player is assigned a list of unique numbers from 1 to T. Each round, a number is drawn among the T numbers, excluding the ones drawn in previous rounds. The game ends when all assigned numbers are drawn.

### Recursive Formula

Let's define the expected number of rounds to end the game as `E(N, T)`, where:

- `N` is the number of unique numbers assigned to the player.
- `T` is the total number of unique numbers.

The recursive formula for `E(N, T)` is:

```markdown
E(N, T) = 1 + 
          (1 / T) * 
          (sum from i=1 to N of 
           (i * E(N-i, T-1)))
```

Here's a step-by-step explanation:

1. **Base Case**: When `N = 0`, the game is already over, so `E(0, T) = 0`.

2. **Recursive Case**: For `N > 0`, consider the first number drawn. There are `T` possible numbers to draw.

3. **Probability**: The probability of drawing any specific number is `1/T`.

4. **Expected Value**: After drawing the first number, there are `N-1` numbers left to draw. The expected number of rounds to draw these remaining numbers is `E(N-1, T-1)`.

5. **Summation**: This process is repeated for each of the `N` numbers. The expected number of rounds to draw all `N` numbers is the sum of these expected values.

### Example Use Case

To calculate `E(3, 5)`, follow these steps:

1. **Base Case**: `E(0, 5) = 0`.

2. **Recursive Case**:
   - For `N = 1`, `E(1, 5) = 1 + (1/5) * E(0, 4) = 1 + (1/5) * 0 = 1`.
   - For `N = 2`, `E(2, 5) = 1 + (1/5) * (E(1, 4) + E(0, 4)) = 1 + (1/5) * (1 + 0) = 1.2`.
   - For `N = 3`, `E(3, 5) = 1 + (1/5) * (E(2, 4) + E(1, 4) + E(0, 4))`.

### Code Implementation

Here's a Python implementation of the recursive formula:

```python
def E(N, T):
    # Base case
    if N == 0:
        return 0
    
    # Initialize sum
    total = 0
    
    # Recursive case
    for i in range(1, N + 1):
        # Calculate E(N-i, T-1)
        remaining = E(N - i, T - 1)
        
        # Add i * E(N-i, T-1) to the total
        total += i * remaining
    
    # Return the expected value
    return 1 + (1 / T) * total

# Example usage
print(E(3, 5))
```

This code calculates the expected number of rounds to end the game for `N = 3` and `T = 5`.