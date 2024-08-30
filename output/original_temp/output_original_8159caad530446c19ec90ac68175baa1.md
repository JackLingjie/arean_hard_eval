**Generating Random Passwords in Python**

The following code generates a random password of a specified length. It includes a mix of uppercase letters, lowercase letters, digits, and special characters.

### Code

```python
import random
import string

def generate_password(length):
    """
    Generates a random password of the specified length.

    Args:
        length (int): The desired length of the password.

    Returns:
        str: A random password.
    """

    # Define the character sets
    uppercase = string.ascii_uppercase
    lowercase = string.ascii_lowercase
    digits = string.digits
    special_chars = string.punctuation

    # Combine all character sets
    all_chars = uppercase + lowercase + digits + special_chars

    # Ensure the password includes at least one character from each set
    password = [
        random.choice(uppercase),
        random.choice(lowercase),
        random.choice(digits),
        random.choice(special_chars),
    ]

    # Fill the rest of the password length
    for _ in range(length - 4):
        password.append(random.choice(all_chars))

    # Shuffle the list to avoid the first characters always being in the same character set order
    random.shuffle(password)

    # Join the characters into a single string
    return "".join(password)

# Example usage
password_length = 12
random_password = generate_password(password_length)
print(f"Generated Password: {random_password}")
```

### Explanation

- **Importing Modules**: The code starts by importing the necessary modules. `random` is used for generating random numbers, and `string` provides access to various string-related constants.
- **`generate_password` Function**: This function takes a single argument, `length`, which specifies the desired length of the generated password.
- **Character Sets**: It defines four character sets:
  - `uppercase`: Uppercase letters.
  - `lowercase`: Lowercase letters.
  - `digits`: Digits.
  - `special_chars`: Special characters.
- **Combining Character Sets**: It combines all these character sets into a single string called `all_chars`.
- **Ensuring Diversity**: To ensure the password includes at least one character from each set, it selects one random character from each set and adds them to the `password` list.
- **Filling the Rest**: It then fills the rest of the password length by appending random characters from `all_chars` to the `password` list.
- **Shuffling**: To avoid the first characters always being in the same character set order, it shuffles the `password` list.
- **Joining Characters**: Finally, it joins the characters in the `password` list into a single string and returns it.
- **Example Usage**: The code demonstrates how to use the `generate_password` function by specifying a password length of 12 and printing the generated password.