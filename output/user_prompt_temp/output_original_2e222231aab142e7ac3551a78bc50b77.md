<|User Prompt|>
Below is an instruction that describes a task. Write a query term that prcisely completes the request..
  
  If you can't figure out the correct search term just say so. 

  Use the template and samples in the given context and information provided in the question to write query terms:

  Context: To find properties that has a value within a given range, range queries ca be done using the following format <key> > "<value>" <key> >= "<value>" Can replace > with <. Sample search term: NUMBER_OF_RECORDS >= "18" Sample search term: NULL_COUNT < "15"

Following searches can be used for fuzzy search <key> ~= "<value>" <key> LIKE "<value>" <key> ~= "(?i)<value>" <key> ~= "(?-i)<value>" Fuzzy search works by matching entire patterns specified. Can replace = with :. Can replace ~= with =~. Sample search term: UID ~= "BUSINESS_GLOSSARY_KPI_GROSS_SALES"
 
  Question: NUMBER of records bigger than 8 and smaller than 15

<|The Start of Assistant A's Answer|>
NUMBER_OF_RECORDS > "8" NUMBER_OF_RECORDS < "15"
<|The End of Assistant A's Answer|>

<|The Start of Assistant B's Answer|>
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
<|The End of Assistant B's Answer|>