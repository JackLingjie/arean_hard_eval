**Connecting FBIDs to Page IDs in Daiquery**

To connect the list of FBIDs from the `dim_tier1_job_final` table to the list of page IDs in the target list, you can use a **left join** or a **subquery**. Here are both approaches:

### **Method 1: Using a Left Join**

```sql
SELECT 
  djf.fb_id,
  tp.page_id
FROM 
  dim_tier1_job_final djf
LEFT JOIN 
  target_pages tp ON djf.fb_id = tp.fb_id;
```

- **Explanation**: 
  - This query joins the `dim_tier1_job_final` table (`djf`) with the `target_pages` table (`tp`) on the `fb_id` column.
  - The `LEFT JOIN` ensures that all records from `dim_tier1_job_final` are included, even if there are no matches in `target_pages`.

### **Method 2: Using a Subquery**

```sql
SELECT 
  djf.fb_id,
  tp.page_id
FROM 
  dim_tier1_job_final djf
INNER JOIN 
  (
    SELECT 
      fb_id 
    FROM 
      target_pages
  ) tp ON djf.fb_id = tp.fb_id;
```

- **Explanation**: 
  - This query uses a subquery to select the `fb_id` from the `target_pages` table.
  - It then joins this subquery with the `dim_tier1_job_final` table on the `fb_id` column.

### **Choosing the Right Method**

- **Left Join**: Use when you want to include all records from `dim_tier1_job_final`, even if there are no matches in `target_pages`.
- **Subquery**: Use when you want to ensure that only matching records are included.

### **Example Use Case**

Suppose you have the following data:

**`dim_tier1_job_final`**

| fb_id |
| --- |
| 123   |
| 456   |
| 789   |

**`target_pages`**

| page_id | fb_id |
| --- | --- |
| 1      | 123   |
| 2      | 456   |

**Query Result**

| fb_id | page_id |
| --- | --- |
| 123   | 1      |
| 456   | 2      |

This result shows the matched `fb_id` from `dim_tier1_job_final` with the corresponding `page_id` from `target_pages`.