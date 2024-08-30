**Cross-Validation using Shuffle Split in Scikit-Learn**

Cross-validation is a technique used to evaluate the performance of a machine learning model by splitting the available data into training and testing sets. Here's an example of how to perform cross-validation using the ShuffleSplit method in Scikit-Learn:

### Example Code

```python
# Import necessary libraries
from sklearn.model_selection import ShuffleSplit
from sklearn.model_selection import cross_val_score
from sklearn.datasets import load_iris
from sklearn.linear_model import LogisticRegression

# Load the iris dataset
iris = load_iris()
X = iris.data
y = iris.target

# Initialize the model
model = LogisticRegression(max_iter=1000)

# Define the number of folds for cross-validation
n_folds = 5

# Create a ShuffleSplit object with the specified number of folds
cv = ShuffleSplit(n_splits=n_folds, test_size=0.2, random_state=42)

# Perform cross-validation
scores = cross_val_score(model, X, y, cv=cv)

# Print the average cross-validation score
print("Average Cross-Validation Score:", scores.mean())
```

### Explanation

1. **Import Libraries**: 
   - `ShuffleSplit` for creating a shuffle-split object.
   - `cross_val_score` for performing cross-validation.
   - `load_iris` for loading the iris dataset.
   - `LogisticRegression` for creating a logistic regression model.

2. **Load the Iris Dataset**: 
   - Load the iris dataset using `load_iris()`.
   - Extract the feature data (`X`) and the target variable (`y`).

3. **Initialize the Model**: 
   - Create a logistic regression model using `LogisticRegression`.

4. **Define the Number of Folds**: 
   - Specify the number of folds (`n_folds`) for cross-validation.

5. **Create a ShuffleSplit Object**: 
   - Create a `ShuffleSplit` object with the specified number of folds (`n_folds`), test size (`0.2`), and random state (`42`).

6. **Perform Cross-Validation**: 
   - Use `cross_val_score` to perform cross-validation on the model with the specified data and `ShuffleSplit` object.

7. **Print the Average Cross-Validation Score**: 
   - Print the average cross-validation score.

This example demonstrates how to use the `ShuffleSplit` method in Scikit-Learn for cross-validation.