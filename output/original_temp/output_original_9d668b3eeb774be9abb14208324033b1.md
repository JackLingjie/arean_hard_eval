**Java Program to Calculate Greatest Common Divisor (GCD)**
===========================================================

### Overview

This Java program prompts the user to enter two positive integers. It then calculates and displays their greatest common divisor (GCD).

### Code

```java
import java.util.Scanner;

public class GCDCalculator {
    public static void main(String[] args) {
        // Create a Scanner object to read user input
        Scanner scanner = new Scanner(System.in);

        // Prompt the user to enter two positive integers
        System.out.print("Enter the first positive integer: ");
        int num1 = scanner.nextInt();

        System.out.print("Enter the second positive integer: ");
        int num2 = scanner.nextInt();

        // Validate user input
        if (num1 <= 0 || num2 <= 0) {
            System.out.println("Both numbers must be positive.");
            return;
        }

        // Calculate the GCD using the Euclidean algorithm
        int gcd = calculateGCD(num1, num2);

        // Display the GCD
        System.out.println("The greatest common divisor (GCD) is: " + gcd);
    }

    /**
     * Calculates the GCD of two numbers using the Euclidean algorithm.
     *
     * @param num1 The first number.
     * @param num2 The second number.
     * @return The GCD of num1 and num2.
     */
    public static int calculateGCD(int num1, int num2) {
        while (num2 != 0) {
            int temp = num2;
            num2 = num1 % num2;
            num1 = temp;
        }
        return num1;
    }
}
```

### Explanation

1. **User Input**: The program uses a `Scanner` object to read two positive integers from the user.
2. **Validation**: It checks if both numbers are positive. If not, it displays an error message and exits.
3. **GCD Calculation**: The `calculateGCD` method uses the Euclidean algorithm to find the GCD of the two numbers.
4. **Result Display**: The program displays the calculated GCD.

### Example Use Case

```
Enter the first positive integer: 48
Enter the second positive integer: 18
The greatest common divisor (GCD) is: 6
```

This program demonstrates a simple and efficient way to calculate the GCD of two positive integers in Java.