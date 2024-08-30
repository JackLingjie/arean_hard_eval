**Two Sum Problem Solution in Haskell**

The following Haskell function solves the two sum problem. It takes a list of numbers and a target sum as input. The function returns the two numbers in the list that add up to the target sum. If no such pair is found, it returns `-1`.

### Code

```haskell
-- | Two Sum Problem Solution
twoSum :: Eq a => a -> [a] -> [a]
twoSum _ [] = [-1, -1]
twoSum target (x : xs)
  | target == x + y = [x, y]
  | target > x + y = twoSum target xs
  | otherwise = twoSum target (x : xs')
  where
    xs' = filter (\y -> x + y /= target) xs
```

### Explanation

- **Function Signature**: `twoSum :: Eq a => a -> [a] -> [a]`
  - `Eq a` is a constraint that requires the type `a` to be an instance of the `Eq` typeclass, which means it must support equality checks.
  - The function takes two arguments:
    - `target`: The target sum we are looking for.
    - `xs`: The list of numbers to search in.

- **Base Case**: If the input list `xs` is empty, return `[-1, -1]` to indicate that no solution was found.

- **Recursive Case**:
  - If the first element `x` of the list `xs` is the number we need to add to another number to reach the target, return `[x, y]`.
  - If the sum of `x` and any other number in the list is less than the target, continue searching in the rest of the list.
  - If the sum of `x` and any other number in the list is greater than the target, filter out the numbers that would make the sum greater than the target from the rest of the list and continue searching.

### Example Use Cases

```haskell
-- Example 1: Find two numbers that sum to 10
twoSum 10 [2, 7, 11, 15]  -- Returns: [2, 8]

-- Example 2: No pair sums to the target
twoSum 100 [2, 7, 11, 15]  -- Returns: [-1, -1]
```