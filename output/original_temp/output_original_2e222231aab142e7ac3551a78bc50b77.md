To find properties with a value within a specific range, you can use the following query terms:

- For a value greater than or equal to a certain number: `<key> >= "<value>"`
- For a value less than a certain number: `<key> < "value"`

Given the task, the query term to find properties with the number of records bigger than 8 and smaller than 15 would be:

```sql
NUMBER_OF_RECORDS > "8" AND NUMBER_OF_RECORDS < "15"
```

This query term ensures that the number of records falls within the specified range. 

If you prefer to use the `>=` and `<=` operators for inclusivity, the query would be:

```sql
NUMBER_OF_RECORDS >= "8" AND NUMBER_OF_RECORDS <= "15"
```