**Converse of Proposition 1.2.8**

### Problem Statement

Prove the converse of Proposition 1.2.8:

- Let \(S\) be a nonempty subset of the real numbers \(\mathbb{R}\) that is bounded above.
- Let \(b_0\) be an upper bound of \(S\).
- If for all \(\epsilon > 0\), there exists an \(x \in S\) such that \(x > b_0 - \epsilon\), then \(b_0 = \sup S\).

### Solution

To prove that \(b_0 = \sup S\), we need to show two things:

1. **\(b_0\) is an upper bound of \(S\)**: This is given.
2. **\(b_0\) is the least upper bound (supremum) of \(S\)**: We need to show that any number less than \(b_0\) is not an upper bound of \(S\).

### Proof

- **Step 1**: Assume there exists a number \(b < b_0\).
- **Step 2**: Choose \(\epsilon = b_0 - b > 0\).
- **Step 3**: By the given condition, there exists an \(x \in S\) such that \(x > b_0 - \epsilon = b_0 - (b_0 - b) = b\).
- **Step 4**: Since \(x > b\), \(b\) is not an upper bound of \(S\).
- **Step 5**: Therefore, any number less than \(b_0\) is not an upper bound of \(S\).
- **Step 6**: Hence, \(b_0\) is the least upper bound (supremum) of \(S\).

### Conclusion

Given that \(b_0\) is an upper bound of \(S\) and for all \(\epsilon > 0\), there exists an \(x \in S\) such that \(x > b_0 - \epsilon\), we have shown that \(b_0 = \sup S\).