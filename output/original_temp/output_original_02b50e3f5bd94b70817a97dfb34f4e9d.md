**Calculating the Series of Exponential Functions**

The following Python function calculates the series of exponential functions. This function takes two parameters: `base` and `n`, where `base` is the base of the exponential function and `n` is the number of terms in the series.

### Code

```python
def exponential_series(base, n):
    """
    Calculate the series of exponential functions.

    Args:
        base (float): The base of the exponential function.
        n (int): The number of terms in the series.

    Returns:
        list: A list of exponential values.
    """
    return [base ** i for i in range(n)]
```

### Example Use Cases

- **Single Term Series**
  ```python
print(exponential_series(2, 1))  # Output: [2]
```

- **Multi-Term Series**
  ```python
print(exponential_series(2, 5))  # Output: [1, 2, 4, 8, 16]
```

- **Series with a Larger Base**
  ```python
print(exponential_series(3, 4))  # Output: [1, 3, 9, 27]
```

### Explanation

- The function `exponential_series` takes two parameters: `base` and `n`.
- It uses a list comprehension to generate the series of exponential functions.
- The expression `base ** i` calculates the `i`-th term of the series.
- The `range(n)` function generates numbers from 0 to `n-1`, which are used as the exponents.
- The function returns a list of exponential values.