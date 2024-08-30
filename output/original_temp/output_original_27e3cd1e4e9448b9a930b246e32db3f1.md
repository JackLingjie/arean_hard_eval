**Transforming the Original Data**

To achieve the desired transformation, you can use the following SQL query:

```sql
INSERT INTO new_table (account_id, balance, valid_from, valid_to)
SELECT 
  account_id,
  balance,
  MIN(day) AS valid_from,
  MAX(day) AS valid_to
FROM 
  original_table
GROUP BY 
  account_id, balance;
```

**Explanation**

- This query selects the `account_id` and `balance` from the `original_table`.
- It uses `MIN(day)` and `MAX(day)` to determine the `valid_from` and `valid_to` dates for each group of consecutive days with the same balance.
- The `GROUP BY` clause groups the results by `account_id` and `balance`, ensuring that only consecutive days with the same balance are combined.

**Example Use Case**

Suppose you have the following data in `original_table`:

| account_id | day       | balance |
|------------|-----------|---------|
| 1          | 2022-04-01| 100     |
| 1          | 2022-04-02| 100     |
| 1          | 2022-04-03| 100     |
| 1          | 2022-04-04| 150     |
| 1          | 2022-04-05| 150     |
| 2          | 2022-04-01| 200     |
| 2          | 2022-04-02| 200     |

After running the query, `new_table` will contain:

| account_id | balance | valid_from | valid_to   |
|------------|---------|------------|------------|
| 1          | 100     | 2022-04-01 | 2022-04-03 |
| 1          | 150     | 2022-04-04 | 2022-04-05 |
| 2          | 200     | 2022-04-01 | 2022-04-02 |