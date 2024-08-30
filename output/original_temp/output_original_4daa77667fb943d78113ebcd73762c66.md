**Calculating Pi using JavaScript**

Here are a few methods to calculate Pi in JavaScript:

### **Method 1: Bailey–Borwein–Plouffe Formula (BBP)**

This formula allows you to calculate any binary digit of Pi.

```javascript
function calculatePi(n) {
  let pi = 0;
  for (let k = 0; k <= n; k++) {
    pi += 1 / Math.pow(16, k) * (
      4 / (8 * k + 1) -
      2 / (8 * k + 4) -
      1 / (8 * k + 5) -
      1 / (8 * k + 6)
    );
  }
  return pi;
}

// Example usage:
const pi = calculatePi(100);
console.log(pi);
```

### **Method 2: Leibniz Formula**

This method uses an infinite series to calculate Pi.

```javascript
function calculatePi(n) {
  let pi = 0;
  for (let i = 0; i <= n; i++) {
    pi += Math.pow(-1, i) / (2 * i + 1);
  }
  return 4 * pi;
}

// Example usage:
const pi = calculatePi(100);
console.log(pi);
```

### **Method 3: Monte Carlo Method**

This method uses random numbers to estimate Pi.

```javascript
function calculatePi(numPoints) {
  let pointsInsideCircle = 0;

  for (let i = 0; i < numPoints; i++) {
    const x = Math.random();
    const y = Math.random();

    if (x * x + y * y <= 1) {
      pointsInsideCircle++;
    }
  }

  return 4 * pointsInsideCircle / numPoints;
}

// Example usage:
const pi = calculatePi(1000000);
console.log(pi);
```

These methods demonstrate different approaches to calculating Pi in JavaScript. Choose the one that best suits your needs.