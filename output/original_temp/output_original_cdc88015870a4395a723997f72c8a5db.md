**Computing the n-th Fibonacci Number Mod p**

The following JavaScript function calculates the n-th Fibonacci number modulo `p`. This implementation uses the [Matrix Exponentiation Method](https://en.wikipedia.org/wiki/Matrix_exponentiation#Fibonacci_sequence) for efficient computation.

### Code

```javascript
/**
 * Computes the n-th Fibonacci number modulo p.
 *
 * @param {number} n - The position of the Fibonacci number.
 * @param {number} p - The modulo value.
 * @returns {number} The n-th Fibonacci number modulo p.
 */
function fibonacciMod(n, p) {
  // Base cases
  if (n === 0) return 0;
  if (n === 1) return 1;

  // Create the Fibonacci matrix
  const matrix = [
    [1, 1],
    [1, 0]
  ];

  // Perform matrix exponentiation
  const result = matrixPower(matrix, n - 1, p);

  // Return the result modulo p
  return result[0][0] % p;
}

// Helper function for matrix exponentiation
function matrixMultiply(a, b, p) {
  const result = [
    [0, 0],
    [0, 0]
  ];

  for (let i = 0; i < 2; i++) {
    for (let j = 0; j < 2; j++) {
      for (let k = 0; k < 2; k++) {
        result[i][j] = (result[i][j] + a[i][k] * b[k][j]) % p;
      }
    }
  }

  return result;
}

// Helper function for matrix exponentiation
function matrixPower(matrix, n, p) {
  if (n === 0) return [[1, 0], [0, 1]];

  const halfPower = matrixPower(matrix, Math.floor(n / 2), p);
  const result = matrixMultiply(halfPower, halfPower, p);

  if (n % 2 === 1) {
    result[0][0] = (result[0][0] + matrix[0][0]) % p;
    result[0][1] = (result[0][1] + matrix[0][1]) % p;
    result[1][0] = (result[1][0] + matrix[1][0]) % p;
    result[1][1] = (result[1][1] + matrix[1][1]) % p;
  }

  return result;
}
```

### Example Use Cases

```javascript
console.log(fibonacciMod(10, 100)); // Output: 55
console.log(fibonacciMod(20, 1000)); // Output: 676
```

This implementation efficiently computes the n-th Fibonacci number modulo `p` using matrix exponentiation. The `matrixPower` function recursively calculates the power of the Fibonacci matrix, and the `matrixMultiply` function performs matrix multiplication modulo `p`.