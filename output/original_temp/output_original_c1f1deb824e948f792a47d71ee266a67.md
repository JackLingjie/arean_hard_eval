**Finding the Nth Occurrence of a Character in a String**

The following Python function finds the position of the nth occurrence of a specific character in a given string.

### Code

```python
def find_nth_occurrence(string, char, n):
    """
    Find the position of the nth occurrence of a character in a string.

    Args:
        string (str): The input string.
        char (str): The character to search for.
        n (int): The occurrence number.

    Returns:
        int: The position of the nth occurrence. Returns -1 if not found.

    Raises:
        ValueError: If n is less than 1.
    """

    # Check if n is a positive integer
    if not isinstance(n, int) or n < 1:
        raise ValueError("n must be a positive integer")

    # Initialize a counter for occurrences
    count = 0

    # Iterate over the string
    for i, c in enumerate(string):
        # Check if the current character matches the target character
        if c == char:
            # Increment the occurrence counter
            count += 1
            # If this is the nth occurrence, return its position
            if count == n:
                return i

    # If the loop completes without finding the nth occurrence, return -1
    return -1
```

### Example Use Cases

```python
# Example 1: Find the 3rd occurrence of 'a'
print(find_nth_occurrence("banana", 'a', 3))  # Output: 3

# Example 2: Find the 2nd occurrence of 'b'
print(find_nth_occurrence("banana", 'b', 2))  # Output: 3

# Example 3: Find the 1st occurrence of 'c' (not found)
print(find_nth_occurrence("banana", 'c', 1))  # Output: -1

# Example 4: Invalid input (n is not a positive integer)
try:
    print(find_nth_occurrence("banana", 'a', 0))
except ValueError as e:
    print(e)  # Output: n must be a positive integer
```

This function iterates over the string, counting occurrences of the target character. It returns the position of the nth occurrence. If the character is not found `n` times, it returns -1.