**Proof that \( \mathbb{Q}(\sqrt{-11}) \) is a Principal Ideal Domain (PID)**

To prove that \( \mathbb{Q}(\sqrt{-11}) \) is a Principal Ideal Domain (PID), we need to show that every ideal in this ring is principal.

### Step 1: Define the Ring

The ring \( \mathbb{Q}(\sqrt{-11}) \) consists of elements of the form \( a + b\sqrt{-11} \), where \( a, b \in \mathbb{Q} \).

### Step 2: Establish the Norm

For any element \( \alpha = a + b\sqrt{-11} \) in \( \mathbb{Q}(\sqrt{-11}) \), define the norm \( N(\alpha) = (a + b\sqrt{-11})(a - b\sqrt{-11}) = a^2 + 11b^2 \).

### Step 3: Show the Norm Property

- **Multiplicative Property**: For any \( \alpha, \beta \in \mathbb{Q}(\sqrt{-11}) \), \( N(\alpha\beta) = N(\alpha)N(\beta) \).
- **Non-Negativity**: For any \( \alpha \in \mathbb{Q}(\sqrt{-11}) \), \( N(\alpha) \geq 0 \).
- **Zero Divisor**: If \( N(\alpha) = 0 \), then \( \alpha = 0 \).

### Step 4: Prove Every Ideal is Principal

Let \( I \) be an ideal in \( \mathbb{Q}(\sqrt{-11}) \). We aim to show that \( I \) is principal.

- **Case 1**: If \( I = \{0\} \), then \( I \) is principal.
- **Case 2**: If \( I \neq \{0\} \), let \( \alpha \in I \) be a non-zero element with the smallest positive norm. We claim that \( I = (\alpha) \).

### Step 5: Show \( I = (\alpha) \)

- **Step 1**: For any \( \beta \in I \), we have \( N(\beta) = N(\alpha)N(\gamma) \) for some \( \gamma \in \mathbb{Q}(\sqrt{-11}) \).
- **Step 2**: Since \( N(\alpha) \) is minimal, \( N(\gamma) = 1 \), implying \( \gamma \in \mathbb{Q} \).
- **Step 3**: Therefore, \( \beta = \alpha\gamma \in (\alpha) \), showing that \( I \subseteq (\alpha) \).
- **Step 4**: Since \( \alpha \in I \), we also have \( (\alpha) \subseteq I \), thus \( I = (\alpha) \).

### Conclusion

Every ideal in \( \mathbb{Q}(\sqrt{-11}) \) is principal, making it a Principal Ideal Domain (PID).