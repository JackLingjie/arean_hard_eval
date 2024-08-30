**Tuple Comprehensions in Python**

Tuple comprehensions in Python are a concise way to create tuples from iterables. They follow a similar syntax to list comprehensions.

### Basic Syntax

```python
new_tuple = (expression for variable in iterable)
```

- `expression` is the value to be included in the tuple.
- `variable` is the temporary variable used to represent each item in the `iterable`.
- `iterable` is the list, tuple, or other iterable from which to get the values.

### Example

```python
# Create a tuple of squares of numbers from 0 to 4
numbers = [0, 1, 2, 3, 4]
squares = (x**2 for x in numbers)
print(squares)  # Output: (0, 1, 4, 9, 16)
```

### Multiple Iterables

You can also use multiple iterables in a tuple comprehension.

```python
# Create a tuple of pairs from two lists
list1 = [1, 2, 3]
list2 = ['a', 'b', 'c']
pairs = ((x, y) for x, y in zip(list1, list2))
print(pairs)  # Output: ((1, 'a'), (2, 'b'), (3, 'c'))
```

### Filtering

You can filter items using conditional statements.

```python
# Create a tuple of even numbers from a list
numbers = [1, 2, 3, 4, 5]
even_numbers = (x for x in numbers if x % 2 == 0)
print(even_numbers)  # Output: (2, 4)
```

### Nested Comprehensions

You can use nested comprehensions to create more complex data structures.

```python
# Create a tuple of tuples with squares of numbers
numbers = [0, 1, 2, 3, 4]
squares = ((x, x**2) for x in numbers)
print(squares)  # Output: ((0, 0), (1, 1), (2, 4), (3, 9), (4, 16))
```