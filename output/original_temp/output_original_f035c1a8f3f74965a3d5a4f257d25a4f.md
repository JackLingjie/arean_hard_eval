**Open Information Extraction**

Given a text passage, the following LLM model output extracts structured information in JSON format.

### Example 1

**Input**: Apple Inc. is headquartered in Cupertino, California. Tim Cook is the CEO of Apple.

**Output**:
```json
{
  "entities": [
    [1, "Apple Inc.", "Company"],
    [2, "Cupertino, California", "Location"],
    [3, "Tim Cook", "Person"]
  ],
  "relationships": [
    [1, "is headquartered in", 2],
    [3, "is the CEO of", 1]
  ]
}
```

### Example 2

**Input**: Sorry!

**Output**:
```json
{
  "entities": [],
  "relationships": []
}
```

### Example 3

**Input**: 
- Barack Obama was the 44th president of the United States.
- He was born in Honolulu, Hawaii, on August 4, 1961.
- He graduated from Columbia University and Harvard Law School.
- He served in the Illinois State Senate from 1997 to 2004.
- In 2008, he was elected president of the United States, defeating Republican nominee John McCain.
- He was re-elected in 2012, defeating Republican nominee Mitt Romney.

**Output**:
```json
{
  "entities": [
    [1, "Barack Obama", "Person"],
    [2, "United States", "Location"],
    [3, "Honolulu, Hawaii", "Location"],
    [4, "Columbia University", "Organization"],
    [5, "Harvard Law School", "Organization"],
    [6, "Illinois State Senate", "Organization"],
    [7, "John McCain", "Person"],
    [8, "Mitt Romney", "Person"]
  ],
  "relationships": [
    [1, "was the", 2],
    [1, "was born in", 3],
    [1, "graduated from", 4],
    [1, "graduated from", 5],
    [1, "served in", 6],
    [1, "was elected president of", 2],
    [1, "defeated", 7],
    [1, "was re-elected, defeating", 8]
  ]
}
```