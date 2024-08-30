**Counting Distinct Values with a Constraint**

To count distinct values in a column `column_name` while applying a constraint from another column `constraint_column`, use the `OVER` clause in SQL Server Management Studio (SSMS). 

### Example Query

```sql
SELECT 
    constraint_column,
    column_name,
    COUNT(DISTINCT column_name) OVER (PARTITION BY constraint_column) AS distinct_count
FROM 
    your_table;
```

### Explanation

- **`constraint_column`**: The column that defines the constraint.
- **`column_name`**: The column for which you want to count distinct values.
- **`COUNT(DISTINCT column_name) OVER (PARTITION BY constraint_column)`**:
  - `COUNT(DISTINCT column_name)`: Counts the distinct values in `column_name`.
  - `OVER (PARTITION BY constraint_column)`: Groups the result by the values in `constraint_column`.

### Example Use Case

Suppose you have a table named `orders` with columns `customer_id` and `product_name`. You want to count the distinct products ordered by each customer.

```sql
SELECT 
    customer_id,
    product_name,
    COUNT(DISTINCT product_name) OVER (PARTITION BY customer_id) AS distinct_products
FROM 
    orders;
```

This query will return each customer's ID, the products they ordered, and the number of distinct products ordered by each customer.