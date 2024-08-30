**Pivoting Data in Excel**

To transform multiple rows of data into one row of data in Excel, you can use the **PivotTable** feature or the **Power Query** tool. Here are the steps for both methods:

### Method 1: Using PivotTable

1. **Select the Data**:
   - Choose the entire dataset.
2. **Create a PivotTable**:
   - Go to the **"Insert"** tab.
   - Click on **"PivotTable"**.
3. **Configure the PivotTable**:
   - Drag the **column headers** into the **"Row Labels"** and **"Values"** sections.
   - Adjust the **"Values"** section to display the desired data.

### Method 2: Using Power Query

1. **Select the Data**:
   - Choose the entire dataset.
2. **Load to Power Query**:
   - Go to the **"Data"** tab.
   - Click on **"From Table/Range"**.
3. **Transform the Data**:
   - Use the **"Unpivot Columns"** feature to transform the data.

### Example Use Case

Suppose you have a table with the following structure:

| **Name** | **Year** | **Sales** |
| --- | --- | --- |
| John   | 2020   | 100     |
| John   | 2021   | 120     |
| Jane   | 2020   | 80      |
| Jane   | 2021   | 90      |

**Desired Output**:

| **Name** | **Year** | **2020 Sales** | **2021 Sales** |
| --- | --- | --- | --- |
| John   | 2020   | 100     | 120     |
| Jane   | 2020   | 80      | 90      |

**Using PivotTable**:

1. Select the entire dataset.
2. Go to the **"Insert"** tab and click on **"PivotTable"**.
3. Drag **"Name"** into the **"Row Labels"** section.
4. Drag **"Year"** into the **"Column Labels"** section.
5. Drag **"Sales"** into the **"Values"** section.

**Using Power Query**:

1. Select the entire dataset.
2. Go to the **"Data"** tab and click on **"From Table/Range"**.
3. Use the **"Unpivot Columns"** feature to transform the data.

Both methods will produce the desired output.