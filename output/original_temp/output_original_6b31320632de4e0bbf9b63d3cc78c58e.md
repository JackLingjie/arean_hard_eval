## Step 1: Understanding the problem
The problem describes a table-tennis championship with $2^n$ players participating in a knock-out tournament with $n$ rounds. We need to calculate the probability of two randomly chosen players meeting in different rounds.

## Step 2: Calculating the probability of meeting in the first round
For two players to meet in the first round, they must be in the same group. Since there are $2^{n-1}$ players in each group, the probability of choosing two players from the same group is $\frac{1}{2^{n-1}}$.

## Step 3: Calculating the probability of meeting in the final
For two players to meet in the final, they must be the last two players remaining in the tournament. Since there are $2^n$ players initially, the probability of choosing the last two players is $\frac{1}{2^n}$.

## Step 4: Calculating the probability of meeting in any round
To calculate the probability of meeting in any round, we need to consider the number of ways two players can meet in each round and sum them up. However, this approach is complex due to the varying number of players in each round.

## Step 5: Simplifying the calculation for meeting in any round
Instead of calculating the probability for each round separately, we can use a different approach. The probability of two players meeting in any round is equivalent to the probability of them not meeting in any round and then subtracting that from 1.

## Step 6: Calculating the probability of not meeting in any round
To calculate the probability of not meeting in any round, we consider the number of ways two players can be chosen such that they do not meet in any round. This involves choosing one player from each group in each round.

## Step 7: Calculating the probability of not meeting in any round (continued)
In the first round, there are $2^{n-1}$ groups, and we choose one player from each group. This results in $2^{n-1}$ possible pairs. In the second round, there are $2^{n-2}$ groups, and we choose one player from each group, resulting in $2^{n-2}$ possible pairs. This process continues until the final round.

## Step 8: Calculating the total number of possible pairs
The total number of possible pairs is $2^{n-1} + 2^{n-2} + \cdots + 2^1 + 2^0$.

## Step 9: Calculating the probability of not meeting in any round (continued)
The probability of not meeting in any round is $\frac{2^{n-1} + 2^{n-2} + \cdots + 2^1 + 2^0}{2^n}$.

## Step 10: Calculating the probability of meeting in any round
The probability of meeting in any round is $1 - \frac{2^{n-1} + 2^{n-2} + \cdots + 2^1 + 2^0}{2^n}$.

## Step 11: Simplifying the expression for the probability of meeting in any round
We can simplify the expression by using the formula for the sum of a geometric series: $2^{n-1} + 2^{n-2} + \cdots + 2^1 + 2^0 = 2^n - 1$.

## Step 12: Calculating the final probability
The probability of meeting in any round is $1 - \frac{2^n - 1}{2^n} = \frac{1}{2^n}$.

## Step 13: Calculating the final probabilities for (a) and (b)
The probability of meeting in the first round is $\frac{1}{2^{n-1}}$, and the probability of meeting in the final is $\frac{1}{2^n}$.

## Step 14: Finalizing the answer
We have calculated the probabilities for meeting in the first round, final, and any round.

The final answer is: $\boxed{\frac{1}{2^{n-1}}, \frac{1}{2^n}, \frac{1}{2^n}}$