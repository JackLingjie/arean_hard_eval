**Reversing Lines in Gambit Scheme**

This program reads lines from standard input, reverses each line, and prints the modified lines to standard output.

### Code

```scheme
(define (reverse-lines)
  ; Read all lines from standard input
  (define lines (map (lambda (line) (string-trim line)) (port->lines (current-input-port))))

  ; Reverse each line
  (define reversed-lines (map reverse lines))

  ; Print the reversed lines to standard output
  (for-each (lambda (line) (display line) (newline)) reversed-lines))

(reverse-lines)
```

### Explanation

1. **Read Lines**: The `port->lines` function reads all lines from the current input port (standard input).
2. **Trim Lines**: `string-trim` removes leading and trailing whitespace from each line.
3. **Reverse Lines**: `reverse` reverses the order of characters in each line.
4. **Print Reversed Lines**: `for-each` applies the `display` and `newline` functions to each reversed line.

### Running the Program

To run this program:

1. Save the code in a file with a `.scm` extension.
2. Compile the file using `gambit` (e.g., `gambit myprogram.scm`).
3. Run the compiled program (e.g., `./myprogram`).

### Example Use Case

Input:
```text
Hello World
This is a test
```

Output:
```text
dlroW olleH
tset a si sihT
```