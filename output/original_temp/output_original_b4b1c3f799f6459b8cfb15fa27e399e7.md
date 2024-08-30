**Determining if a Number is Odd in Scheme**

To decide whether a number is odd in Scheme, you can use a simple function that checks the remainder of the number when divided by 2. If the remainder is 1, the number is odd.

### Scheme Code

```scheme
; Define a function to check if a number is odd
(define (odd? n)
  ; Use the modulo operator to find the remainder
  (= (modulo n 2) 1))

; Example usage:
(display "Is 5 odd? ") (newline)
(display (odd? 5)) (newline)

(display "Is 10 odd? ") (newline)
(display (odd? 10)) (newline)
```

### Explanation

- **`define`**: This keyword is used to define a function in Scheme.
- **`odd?`**: This is the name of the function. The question mark at the end is a convention in Scheme to indicate that this function returns a boolean value.
- **`modulo`**: This function calculates the remainder of the division of `n` by 2.
- **`=`**: This is the equality predicate, which returns `#t` (true) if the two arguments are equal and `#f` (false) otherwise.
- **Example usage**: Demonstrates how to use the `odd?` function to check if numbers are odd.

### Running the Code

To run this code, you'll need a Scheme interpreter. Some popular choices include:

- **DrRacket**: A graphical development environment for Scheme.
- **Guile**: A Scheme implementation that can be used in various environments.

Save the code in a file with a `.scm` extension and run it using your chosen Scheme interpreter.