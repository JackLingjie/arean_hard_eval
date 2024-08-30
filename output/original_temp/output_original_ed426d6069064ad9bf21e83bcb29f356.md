**Generating Cryptographically Secure Random Numbers**

To generate cryptographically secure random numbers, you can use the `secrets` module in Python. This module is designed to generate cryptographically strong random numbers suitable for managing data such as passwords, account authentication, security tokens, and related secrets.

### Example Function

```python
import secrets

def generate_secure_random_number(min_value: int, max_value: int) -> int:
    """
    Generates a cryptographically secure random number within a specified range.

    Args:
    - min_value (int): The minimum value in the range (inclusive).
    - max_value (int): The maximum value in the range (inclusive).

    Returns:
    - int: A cryptographically secure random number within the specified range.
    """
    return secrets.randbelow(max_value - min_value + 1) + min_value

# Example usage:
random_number = generate_secure_random_number(1, 100)
print(f"Generated Secure Random Number: {random_number}")
```

### Explanation

- **Importing the `secrets` Module**: The `secrets` module is used for generating cryptographically strong random numbers.
- **Defining the `generate_secure_random_number` Function**: This function takes two parameters, `min_value` and `max_value`, which define the range of numbers to generate.
- **Using `secrets.randbelow`**: This function generates a cryptographically secure random integer in the range \[0, n\). To generate a random number within a specified range \[`min_value`, `max_value`\], we use `secrets.randbelow(max_value - min_value + 1) + min_value`.
- **Example Usage**: The function is called with a range from 1 to 100, and the generated random number is printed.

### Advice

- Always use the `secrets` module for generating cryptographically secure random numbers.
- Ensure the range of values is correctly defined to avoid potential errors.
- This function is suitable for a wide range of applications requiring secure random numbers.