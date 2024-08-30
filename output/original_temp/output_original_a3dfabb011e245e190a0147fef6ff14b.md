**Finding the Maximum Length of a Contiguous Subarray with Equal 0s and 1s**

Given a binary array `nums`, the goal is to find the maximum length of a contiguous subarray that contains an equal number of 0s and 1s.

### Example Use Cases

- **Input**: `nums = [0, 1]`
- **Output**: `2`
  - The longest contiguous subarray with an equal number of 0s and 1s is `[0, 1]` with a length of 2.

- **Input**: `nums = [0, 1, 0]`
- **Output**: `2`
  - The longest contiguous subarray with an equal number of 0s and 1s is either `[0, 1]` or `[1, 0]`, both with a length of 2.

- **Input**: `nums = [0, 0, 0, 1, 1, 1]`
- **Output**: `6`
  - The longest contiguous subarray with an equal number of 0s and 1s is `[0, 0, 0, 1, 1, 1]` with a length of 6.

### Solution

```python
def findMaxLength(nums):
    """
    Finds the maximum length of a contiguous subarray with an equal number of 0s and 1s.

    Args:
    - nums (list): A binary array containing only 0s and 1s.

    Returns:
    - int: The maximum length of a contiguous subarray with an equal number of 0s and 1s.
    """
    max_length = 0
    count = 0
    count_dict = {0: -1}  # Initialize dictionary with 0: -1

    for i, num in enumerate(nums):
        # Update count based on the current number
        if num == 0:
            count -= 1
        else:
            count += 1

        # If count is already in the dictionary, update max_length
        if count in count_dict:
            max_length = max(max_length, i - count_dict[count])
        else:
            # Otherwise, add count to the dictionary
            count_dict[count] = i

    return max_length

# Example usage:
print(findMaxLength([0, 1]))  # Output: 2
print(findMaxLength([0, 1, 0]))  # Output: 2
print(findMaxLength([0, 0, 0, 1, 1, 1]))  # Output: 6
```

### Explanation

- The function `findMaxLength` takes a binary array `nums` as input.
- It initializes variables to keep track of the maximum length (`max_length`), the current count of 0s and 1s (`count`), and a dictionary (`count_dict`) to store the count and its index.
- The function iterates over the array, updating the `count` based on the current number.
- If the updated `count` is already in the `count_dict`, it updates `max_length` with the maximum length found so far.
- Otherwise, it adds the updated `count` to the `count_dict`.
- Finally, the function returns the maximum length found.

### Time Complexity

- The time complexity of this solution is O(n), where n is the length of the input array `nums`. This is because each element in the array is processed once.

### Space Complexity

- The space complexity is O(n) due to the use of the `count_dict` dictionary.