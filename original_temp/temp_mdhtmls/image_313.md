Here's a Python script that calculates the derivative of a function using the Average Rate of Change formula:

```python
# Function to calculate the derivative using the Average Rate of Change formula
def derivative(f, a, b, x):
    return (f(b) - f(a)) / (b - a) * (x - a)

# Example function
def f(x):
    return x**2 + 3*x - 5

# User input for x
x = float(input("Enter a value for x: "))

# Calculate the derivative at x
a = 0
b = 1
derivative_value = derivative(f, a, b, x)

# Print the result
print("The derivative of f(x) at x =", x, "is approximately", round(derivative_value, 4))
```

When you run this script, it will prompt you to enter a value for x. Once you enter a value, the script will calculate the derivative of the example function f(x) at that point using the Average Rate of Change formula, and print the result.