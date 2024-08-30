**Minimum Subset of Variables**

You have a set of examples with assignments of $n$ variables $x_1, x_2, ..., x_n$. Each example is labeled as a solution (+) or non-solution (-). The goal is to find the minimum subset of variables such that it is possible to distinguish between (+) and (-) by observing only these variables.

### Step-by-Step Solution

1. **Identify Key Variables**:
   - Start by examining each variable's impact on distinguishing between (+) and (-) examples.

2. **Construct a Decision Tree**:
   - Create a decision tree where each internal node represents a variable.
   - Each leaf node represents a class label (+ or -).

3. **Prune the Tree**:
   - Remove any branches that do not contribute to the decision-making process.

4. **Extract the Minimum Subset**:
   - The minimum subset of variables is the set of variables that appear in the pruned decision tree.

### Example Use Case

Suppose we have the following examples:

| $x_1$ | $x_2$ | $x_3$ | Label |
| --- | --- | --- | --- |
| 0   | 0   | 0   | -    |
| 0   | 0   | 1   | +    |
| 0   | 1   | 0   | -    |
| 0   | 1   | 1   | +    |
| 1   | 0   | 0   | -    |
| 1   | 0   | 1   | +    |
| 1   | 1   | 0   | -    |
| 1   | 1   | 1   | +    |

### Code Implementation

```python
import pandas as pd

# Define the data
data = {
    'x1': [0, 0, 0, 0, 1, 1, 1, 1],
    'x2': [0, 0, 1, 1, 0, 0, 1, 1],
    'x3': [0, 1, 0, 1, 0, 1, 0, 1],
    'label': [-1, 1, -1, 1, -1, 1, -1, 1]
}

# Create a DataFrame
df = pd.DataFrame(data)

# Initialize an empty list to store the minimum subset
min_subset = []

# Iterate over each column in the DataFrame
for col in df.columns:
    # If the column is not 'label'
    if col != 'label':
        # Calculate the information gain
        info_gain = calculate_info_gain(df, col)
        
        # If the information gain is greater than 0
        if info_gain > 0:
            # Add the column to the minimum subset
            min_subset.append(col)

# Print the minimum subset
print(min_subset)
```

### Explanation

This code snippet demonstrates how to find the minimum subset of variables required to distinguish between (+) and (-) examples.

- It starts by defining the data in a dictionary format.
- The data is then converted into a pandas DataFrame for easier manipulation.
- An empty list `min_subset` is initialized to store the minimum subset of variables.
- The code iterates over each column in the DataFrame (excluding the 'label' column).
- For each column, it calculates the information gain using the `calculate_info_gain` function.
- If the information gain is greater than 0, the column is added to the `min_subset`.
- Finally, the minimum subset of variables is printed.

### Note

The `calculate_info_gain` function is not implemented here. It should calculate the information gain for each column based on the class labels.