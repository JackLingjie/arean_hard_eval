**Converting Months to Month Numbers in Rust**

The following function takes a month name as input and returns its corresponding month number.

### Code

```rust
/// Converts a month name to its corresponding month number.
///
/// # Examples
///
/// ```
/// assert_eq!(convert_month_to_number("January"), 1);
/// assert_eq!(convert_month_to_number("February"), 2);
/// assert_eq!(convert_month_to_number("December"), 12);
/// ``` 

fn convert_month_to_number(month: &str) -> u32 {
    match month {
        "January" => 1,
        "February" => 2,
        "March" => 3,
        "April" => 4,
        "May" => 5,
        "June" => 6,
        "July" => 7,
        "August" => 8,
        "September" => 9,
        "October" => 10,
        "November" => 11,
        "December" => 12,
        _ => panic!("Invalid month"),
    }
}
```

### Explanation

- This function uses a `match` statement to compare the input month with the names of all 12 months.
- For each valid month, it returns the corresponding month number.
- If the input month is not recognized, it panics with an error message.

### Example Use Cases

```rust
fn main() {
    assert_eq!(convert_month_to_number("January"), 1);
    assert_eq!(convert_month_to_number("February"), 2);
    assert_eq!(convert_month_to_number("December"), 12);
}
```

This function is straightforward and easy to use. However, for a more robust solution, consider using a data structure like a `HashMap` to store month names and their corresponding numbers. This approach allows for easier extension and modification. 

### Alternative Implementation

```rust
use std::collections::HashMap;

lazy_static! {
    static ref MONTHS: HashMap<&str, u32> = [
        ("January", 1),
        ("February", 2),
        ("March", 3),
        ("April", 4),
        ("May", 5),
        ("June", 6),
        ("July", 7),
        ("August", 8),
        ("September", 9),
        ("October", 10),
        ("November", 11),
        ("December", 12),
    ]
    .iter()
    .cloned()
    .collect();
}

fn convert_month_to_number(month: &str) -> u32 {
    MONTHS.get(month).copied().unwrap_or_else(|| panic!("Invalid month"))
}
```

This version uses a `HashMap` to store month names and their corresponding numbers. It provides a more flexible and efficient way to handle month conversions.