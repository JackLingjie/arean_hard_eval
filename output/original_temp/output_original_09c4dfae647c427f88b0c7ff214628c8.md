**Selecting Top 10 Rows with Joins**

To retrieve the top 10 rows from a database and perform joins with three different tables based on a field called `code`, use the following SQL query:

### SQL Query

```sql
-- Select the top 10 rows from the main table
SELECT 
    m.code,
    m.name,
    t1.value AS table1_value,
    t2.description AS table2_description,
    t3.category AS table3_category
FROM 
    main_table m
-- Join table1 on the 'code' field
LEFT JOIN 
    table1 t1 ON m.code = t1.code
-- Join table2 on the 'code' field
LEFT JOIN 
    table2 t2 ON m.code = t2.code
-- Join table3 on the 'code' field
LEFT JOIN 
    table3 t3 ON m.code = t3.code
-- Order by a relevant field and limit to the top 10 rows
ORDER BY 
    m.id DESC
LIMIT 
    10;
```

### Explanation

- **Main Table Selection**: The query starts by selecting the top 10 rows from the `main_table` based on the `id` field in descending order (`m.id DESC`).
- **Joins**: It then performs three left joins with `table1`, `table2`, and `table3` based on the `code` field. This ensures that all rows from the main table are included, even if there are no matches in the joined tables.
- **Selected Fields**: The query selects specific fields from each table:
  - `m.code` and `m.name` from the main table.
  - `t1.value` from `table1`.
  - `t2.description` from `table2`.
  - `t3.category` from `table3`.

### Example Use Case

Suppose you have a database with the following structure:

- **main_table**:
  | id | code | name |
  |----|------|------|
  | 1  | A    | Item A |
  | 2  | B    | Item B |
  | 3  | C    | Item C |
  | 4  | D    | Item D |
  | 5  | E    | Item E |

- **table1**:
  | code | value |
  |------|-------|
  | A    | Value A |
  | B    | Value B |
  | C    | Value C |

- **table2**:
  | code | description |
  |------|-------------|
  | A    | Description A |
  | B    | Description B |

- **table3**:
  | code | category |
  |------|----------|
  | A    | Category A |
  | C    | Category C |

The query will return the top 10 rows from the `main_table` with the corresponding data from `table1`, `table2`, and `table3`.