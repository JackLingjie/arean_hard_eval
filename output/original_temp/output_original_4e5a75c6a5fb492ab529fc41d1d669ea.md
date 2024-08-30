**Calculating the 95% Confidence Interval for the Sum of 100 Fair Six-Sided Dice**

To calculate the 95% confidence interval for the sum of 100 fair six-sided dice, we need to follow these steps:

### Step 1: Determine the Mean and Standard Deviation

- **Mean**: The mean of a single six-sided die is `(1 + 6) / 2 = 3.5`.
- **Standard Deviation**: The standard deviation of a single six-sided die is `sqrt((1^2 + 2^2 + 3^2 + 4^2 + 5^2 + 6^2) / 6 - 3.5^2) = sqrt(35/6 - 12.25) = sqrt(3.0833 - 12.25) = sqrt(-9.1667) = 3.038`.

### Step 2: Calculate the Standard Error

- **Standard Error**: The standard error for the sum of 100 dice is `3.038 * sqrt(100) = 30.38`.

### Step 3: Determine the Critical Value

- **Critical Value**: For a 95% confidence interval, the critical value from the standard normal distribution is approximately `1.96`.

### Step 4: Calculate the Margin of Error

- **Margin of Error**: The margin of error is `1.96 * 30.38 = 59.43`.

### Step 5: Calculate the Confidence Interval

- **Lower Bound**: The lower bound of the confidence interval is `100 * 3.5 - 59.43 = 350 - 59.43 = 290.57`.
- **Upper Bound**: The upper bound of the confidence interval is `100 * 3.5 + 59.43 = 350 + 59.43 = 409.43`.

### Step 6: Interpret the Results

The 95% confidence interval for the sum of 100 fair six-sided dice is `(290.57, 409.43)`. This means that we are 95% confident that the true sum of the dice lies within this interval.

**Example Use Case**

This calculation can be applied to any scenario where you need to estimate the sum of a large number of independent random variables with known mean and standard deviation.