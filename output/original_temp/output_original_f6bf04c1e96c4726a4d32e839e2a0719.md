**Creating a Scale Index**

To create an index between 0 and 1, where 1 is the best, you can use the following Python function:

### Scale Index Function

```python
def scale_to_index(score):
    """
    Convert a score from 1-7 to an index between 0 and 1.

    Args:
        score (int): The score to convert (1-7).

    Returns:
        float: The index between 0 and 1.

    Raises:
        ValueError: If the score is not between 1 and 7.
    """
    if not 1 <= score <= 7:
        raise ValueError("Score must be between 1 and 7")

    # Calculate the index by subtracting the score from 7 and dividing by 6
    index = (7 - score) / 6

    return index
```

### Example Use Cases

```python
# Best score (1)
print(scale_to_index(1))  # Output: 1.0

# Worst score (7)
print(scale_to_index(7))  # Output: 0.0

# Middle score (4)
print(scale_to_index(4))  # Output: 0.5
```

This function takes a score between 1 and 7, subtracts it from 7, and then divides by 6 to create an index between 0 and 1. If the input score is not within the valid range, it raises a `ValueError`.