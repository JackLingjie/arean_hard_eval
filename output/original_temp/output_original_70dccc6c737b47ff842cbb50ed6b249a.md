**Code Review**

The provided Arduino code, `cycleLEDs`, is generally well-structured. However, there are areas for improvement to enhance understandability, optimization, and size.

### Understandability

- **Variable Naming**: Variable names like `nOutPins` and `outPins` are clear. However, `currIndex` and `nextIndex` could be more descriptive.

- **Comments**: While the code has some comments, they are sparse. Adding more comments would improve readability.

### Optimization

- **Redundant Checks**: The conditions `if (nextIndex < 0)` and `if (nextIndex >= nOutPins)` are redundant. The same logic is applied in the `currIndex` update.

- **Direction Calculation**: The `direction` variable is calculated unnecessarily. It can be directly used in the `nextIndex` calculation.

### Size

- **Function Size**: The function is relatively large. Consider breaking it down into smaller functions for better maintainability.

### Suggestions

```cpp
/**
 * Cycle LEDs at a specified interval.
 *
 * @param interval The interval in milliseconds.
 */
void cycleLEDs(int interval) {
  const int nOutPins = sizeof(outPins) / sizeof(outPins[0]);
  static unsigned long lastChange = 0;
  static int currentIndex = 0; // Use static to retain value between function calls

  if (millis() - lastChange >= abs(interval)) {
    // Determine direction
    int direction = interval < 0 ? -1 : 1;

    // Update secondary index
    int nextIndex = (currentIndex + direction + nOutPins) % nOutPins;

    // Turn off all LEDs
    for (int i = 0; i < nOutPins; i++) {
      if (i == currentIndex || i == nextIndex) {
        digitalWrite(outPins[i], HIGH);
      } else {
        digitalWrite(outPins[i], LOW);
      }
    }

    // Update current index
    currentIndex = nextIndex;

    // Update timer
    lastChange = millis();
  }
}
```

### Key Changes

- Simplified the `nextIndex` calculation.
- Removed redundant checks.
- Improved variable naming.
- Added a brief description of the function.

### Additional Advice

- Consider using a more efficient method to update the LEDs, such as using a single `digitalWrite` call for all LEDs at once.
- If the `outPins` array is not modified elsewhere in the code, consider making it a `const` array.
- Use a consistent naming convention throughout the code.