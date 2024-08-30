**Memoization in Python**

To skip a function call if the same parameters were used before, you can implement memoization. Memoization is an optimization technique where you store the results of expensive function calls and return the cached result when the same inputs occur again.

### Example Code

```python
def memoize(func):
    """Decorator to memoize function calls."""
    cache = dict()

    def memoized_func(*args):
        if args in cache:
            # Return cached result if function was called before
            return cache[args]
        else:
            # Calculate result and store it in cache
            result = func(*args)
            cache[args] = result
            return result

    return memoized_func

# Example usage:
@memoize
def expensive_function(a, b):
    """Simulate an expensive function call."""
    print("Calculating...")
    return a + b

# First call: calculates result and stores it in cache
result1 = expensive_function(2, 3)
print(result1)  # Output: 5

# Second call: returns cached result
result2 = expensive_function(2, 3)
print(result2)  # Output: 5 (no calculation)

# Third call: calculates result and stores it in cache
result3 = expensive_function(4, 5)
print(result3)  # Output: 9
```

### Explanation

1. **`memoize` function**: This is a decorator that takes a function `func` as an argument.
2. **`cache` dictionary**: Stores the results of function calls with their corresponding arguments.
3. **`memoized_func`**: The decorated function that checks the cache before calling the original function.
4. **`@memoize` decorator**: Applies the `memoize` decorator to the `expensive_function`.

### Benefits

- **Efficient**: Avoids redundant calculations by storing and reusing results.
- **Easy to implement**: Use the `memoize` decorator to memoize any function.

### Advice

- Use memoization when function calls are expensive or have side effects.
- Be mindful of cache size to avoid memory issues.