**Tracking Clinical Marker Changes Over Time**

When tracking a clinical marker's change over time relative to its reference range, consider the following steps:

### **Step 1: Establish Initial Reference Range**

- **Define the initial reference range**: Determine the normal range for the clinical marker at the beginning of the observation period.
- **Document the reference range**: Record the lower and upper limits of the reference range.

### **Step 2: Monitor Changes Over Time**

- **Collect data**: Continuously collect data on the clinical marker's values over time.
- **Calculate z-scores**: Calculate the z-score for each data point to determine how many standard deviations it is from the mean.

### **Step 3: Update Reference Range**

- **Identify the change point**: Determine the time point when the reference range changes.
- **Update the reference range**: Use the new data to redefine the reference range.

### **Step 4: Recalculate z-scores**

- **Recalculate z-scores**: After updating the reference range, recalculate the z-scores for all data points.

### **Example Use Case**

Suppose we're tracking the white blood cell count (WBC) of a patient over time. Initially, the reference range is 4,500 to 11,000 cells per microliter.

| **Time** | **WBC Count** | **z-score** |
| --- | --- | --- |
| **Day 1** | 8,000 | -0.5 |
| **Day 7** | 12,000 | 1.0 |
| **Day 14** | 9,000 | -0.2 |

After 14 days, the reference range changes to 5,000 to 10,000 cells per microliter.

| **Time** | **WBC Count** | **z-score** |
| --- | --- | --- |
| **Day 1** | 8,000 | -0.5 |
| **Day 7** | 12,000 | 1.0 |
| **Day 14** | 9,000 | -0.2 |

### **Code Implementation**

```python
import pandas as pd

# Define the initial reference range
initial_ref_range = (4500, 11000)

# Define the updated reference range
updated_ref_range = (5000, 10000)

# Define the data
data = {
    'Time': ['Day 1', 'Day 7', 'Day 14'],
    'WBC Count': [8000, 12000, 9000]
}

# Create a DataFrame
df = pd.DataFrame(data)

# Calculate z-scores for the initial reference range
df['z-score'] = (df['WBC Count'] - initial_ref_range[0]) / (initial_ref_range[1] - initial_ref_range[0])

# Update the reference range
df['z-score_updated'] = (df['WBC Count'] - updated_ref_range[0]) / (updated_ref_range[1] - updated_ref_range[0])

print(df)
```

This code demonstrates how to track changes in a clinical marker over time relative to its reference range. It calculates z-scores for both the initial and updated reference ranges.