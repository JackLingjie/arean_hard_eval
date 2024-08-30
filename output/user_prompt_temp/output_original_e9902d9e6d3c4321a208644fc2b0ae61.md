<|User Prompt|>
You have a sales table with the following columns: customer_id, week, date, basket_key, sales, units. Write some SQL code that can, for every product in every week, classify customers as "new" or "existing" depending on whether they had purchased that product in the previous 6 weeks.

<|The Start of Assistant A's Answer|>
To classify customers as "new" or "existing" based on their purchase history, you can use a self-join with a conditional statement. Here's an example SQL code to achieve this:

```sql
WITH sales_with_weeks AS (
  SELECT
    customer_id,
    week,
    date,
    basket_key,
    sales,
    units,
    week - ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY week) AS week_group
  FROM
    sales_table
)

, customer_purchase_history AS (
  SELECT
    a.customer_id,
    a.week,
    a.date,
    a.basket_key,
    a.sales,
    a.units,
    CASE
      WHEN b.customer_id IS NULL THEN 'new'
      ELSE 'existing'
    END AS customer_type
  FROM
    sales_with_weeks a
  LEFT JOIN sales_with_weeks b
    ON a.customer_id = b.customer_id
    AND a.week_group = b.week_group + 1
    AND a.week - b.week BETWEEN 1 AND 6
)

SELECT
  customer_id,
  week,
  date,
  basket_key,
  sales,
  units,
  customer_type
FROM
  customer_purchase_history
ORDER BY
  customer_id,
  week;
```

This code first creates a CTE (Common Table Expression) called `sales_with_weeks` to calculate the `week_group` for each customer and week. Then, it creates another CTE called `customer_purchase_history` to perform a self-join on the `sales_with_weeks` table and classify customers as "new" or "existing" based on their purchase history in the previous 6 weeks. Finally, it selects the required columns and orders the result by `customer_id` and `week`.
<|The End of Assistant A's Answer|>

<|The Start of Assistant B's Answer|>
**Classifying Customers as "New" or "Existing"**

To classify customers as "new" or "existing" based on their purchase history, you can use the following SQL code:

### SQL Code

```sql
WITH 
  -- Calculate the number of weeks a customer has purchased a product
  purchase_history AS (
    SELECT 
      customer_id,
      basket_key,
      week,
      COUNT(DISTINCT week) OVER (PARTITION BY customer_id, basket_key ORDER BY week ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS purchase_count
    FROM 
      sales
  ),
  
  -- Classify customers as "new" or "existing"
  customer_classification AS (
    SELECT 
      customer_id,
      basket_key,
      week,
      CASE 
        WHEN purchase_count = 1 THEN 'new'
        ELSE 'existing'
      END AS customer_type
    FROM 
      purchase_history
  )

-- Final classification
SELECT 
  customer_id,
  basket_key,
  week,
  customer_type
FROM 
  customer_classification;
```

### Explanation

1. **`purchase_history` CTE**:
   - This Common Table Expression (CTE) calculates the number of weeks a customer has purchased a product.
   - It uses the `COUNT(DISTINCT week)` function with a window frame (`ROWS BETWEEN 6 PRECEDING AND CURRENT ROW`) to count the distinct weeks for each customer and product.

2. **`customer_classification` CTE**:
   - This CTE classifies customers as "new" or "existing" based on their purchase history.
   - It uses a `CASE` statement to determine the customer type:
     - If a customer has purchased a product only once in the last 6 weeks, they are classified as "new".
     - Otherwise, they are classified as "existing".

3. **Final Classification**:
   - The final query selects the `customer_id`, `basket_key`, `week`, and `customer_type` from the `customer_classification` CTE.

### Example Use Case

Suppose you have the following data in your `sales` table:

| customer_id | week | date       | basket_key | sales | units |
|-------------|------|------------|------------|-------|-------|
| 1           | 1    | 2022-01-01 | A          | 10    | 2     |
| 1           | 2    | 2022-01-08 | A          | 15    | 3     |
| 1           | 7    | 2022-02-12 | B          | 20    | 4     |
| 2           | 3    | 2022-01-15 | A          | 12    | 2     |
| 2           | 9    | 2022-02-26 | C          | 25    | 5     |

The SQL code will classify customers as "new" or "existing" based on their purchase history. 

For example, customer 1 is classified as "existing" for product A because they purchased it in weeks 1 and 2. Customer 1 is classified as "new" for product B because it was purchased only in week 7. Customer 2 is classified as "new" for product A because it was purchased only in week 3. Customer 2 is classified as "new" for product C because it was purchased only in week 9.
<|The End of Assistant B's Answer|>