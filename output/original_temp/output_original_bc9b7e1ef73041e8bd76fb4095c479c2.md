**Counting Events per Minute**

To count the number of events every minute since one month ago, use the following SQL query:

```sql
SELECT 
  EXTRACT(MINUTE FROM event_at) AS minute,
  COUNT(*) AS event_count
FROM 
  your_table
WHERE 
  event_at >= CURRENT_TIMESTAMP - INTERVAL 1 MONTH
GROUP BY 
  EXTRACT(MINUTE FROM event_at)
ORDER BY 
  minute;
```

**Explanation:**

- **`EXTRACT(MINUTE FROM event_at)`**: This extracts the minute from the `event_at` timestamp.
- **`COUNT(*)`**: This counts the number of events.
- **`WHERE event_at >= CURRENT_TIMESTAMP - INTERVAL 1 MONTH`**: This filters events that occurred within the last month.
- **`GROUP BY EXTRACT(MINUTE FROM event_at)`**: This groups the results by minute.
- **`ORDER BY minute`**: This sorts the results by minute.

**Example Use Case:**

Suppose you have a table named `events` with the specified schema. Running this query will give you the number of events per minute for the last month.

**Tips:**

- Adjust the time interval as needed.
- Use `EXTRACT(HOUR FROM event_at)` for hourly counts or `EXTRACT(DAY FROM event_at)` for daily counts.