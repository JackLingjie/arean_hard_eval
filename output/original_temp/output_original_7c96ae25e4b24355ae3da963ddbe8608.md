**Reversing a List of Strings in Scheme**

Here's a simple function in Scheme that takes a list of strings as input and returns the reversed list.

### Code

```scheme
(define (reverse-string-list lst)
  "Returns the reverse of a list of strings."
  (reverse lst))
```

### Explanation

- **Function Definition**: The `reverse-string-list` function is defined with a docstring that explains its purpose.
- **`reverse` Function**: The built-in `reverse` function in Scheme is used to reverse the order of elements in the input list.

### Example Use Case

```scheme
(define strings-to-reverse '("hello" "world" "scheme"))
(define reversed-list (reverse-string-list strings-to-reverse))

(display "Original List: ")
(display strings-to-reverse)
(newline)

(display "Reversed List: ")
(display reversed-list)
(newline)
```

This example demonstrates how to use the `reverse-string-list` function to reverse a list of strings. The output will show the original list followed by the reversed list.