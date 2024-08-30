To merge the provided code into a single pass call, you can use the `dplyr` and `tidyr` packages in R. Here's how you can do it:

```r
rk <- 
  rk %>% 
  filter(Peptide %in% pp) %>% 
  collect() %>% 
  separate(
    col = "FragType", 
    into = c("Product", "FragZ"), 
    remove = FALSE
  ) %>% 
  replace(is.na(.), 0)
```

Here's a breakdown:

- The `filter` function is used to select rows where the `Peptide` column matches any value in `pp`.
- `collect()` is used to ensure the data is collected from the database or other data source into a local data frame.
- `separate` splits the "FragType" column into two new columns, "Product" and "FragZ", leaving the original column intact.
- `replace(is.na(.), 0)` replaces all `NA` values in the data frame with `0`. The dot (`.`) is a placeholder for the entire data frame.

This single pass call achieves the same result as the original code but in a more concise manner.