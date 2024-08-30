**Prime Number Stream Generation in Rust**

This example demonstrates how to create a prime number stream in Rust. We will use a generator to produce prime numbers on demand.

### `prime_stream.rs`

```rust
// Define a generator for prime numbers
fn prime_stream() -> impl Iterator<Item = u64> {
    // Start from the first prime number, 2
    let mut num = 2;

    // Generator function to produce prime numbers
    move || {
        // Yield the current number
        let current = num;
        num += 1;

        // Check if the current number is prime
        if is_prime(current) {
            Some(current)
        } else {
            None
        }
    }
}

// Helper function to check if a number is prime
fn is_prime(n: u64) -> bool {
    if n <= 1 {
        return false;
    }

    // Check divisibility up to the square root of n
    (2..).take_while(|i| i * i <= n).all(|i| n % i != 0)
}

fn main() {
    // Create a prime number stream
    let mut prime_stream = prime_stream();

    // Print the first 10 prime numbers
    for _ in 0..10 {
        match prime_stream.next() {
            Some(prime) => println!("{}", prime),
            None => break,
        }
    }
}
```

### Explanation

- **`prime_stream` Function**: This function returns an iterator over prime numbers. It starts from 2 and yields each prime number found.

- **`is_prime` Function**: This helper function checks whether a given number is prime. It returns `false` for numbers less than or equal to 1. For other numbers, it checks divisibility up to the square root of the number.

- **`main` Function**: In the `main` function, we create a prime number stream and print the first 10 prime numbers.

### Running the Code

To run this code:

1. **Save** the code in a file named `prime_stream.rs`.
2. **Compile** the code using `rustc prime_stream.rs`.
3. **Run** the compiled program using `./prime_stream`.

This will print the first 10 prime numbers.