**Filtering and Deleting Rows in Excel**

To delete rows in an Excel table where a specific column value is 0, follow these steps:

### Step 1: **Select the Data Range**

- **Step 1**: Select the entire data range that includes the column you want to check.

### Step 2: **Filter the Data**

- **Step 2**: Go to the "Data" tab in the Excel ribbon.
- **Step 3**: Click on "Filter" in the "Data Tools" group.

### Step 3: **Apply Filter Criteria**

- **Step 4**: Click on the dropdown arrow in the header of the column you want to filter.
- **Step 5**: Select "0" from the list.

### Step 4: **Delete Rows**

- **Step 6**: Select all the rows that are filtered out by clicking on the header row and dragging down.
- **Step 7**: Right-click on the selected rows.
- **Step 8**: Choose "Delete" from the context menu.

### Alternative Method: Using Formulas

Alternatively, you can use formulas to achieve the same result:

- **Step 9**: Select the entire data range.
- **Step 10**: Go to the "Data" tab.
- **Step 11**: Click on "Sort & Filter" > "Advanced Filter".
- **Step 12**: In the "Advanced Filter" dialog box:
  - **Step 13**: Select "Copy to another location".
  - **Step 14**: Choose a cell range to copy the filtered data.
  - **Step 15**: In the "Criteria range" field, enter `=A1:A10` (assuming your data starts in cell A1).
  - **Step 16**: In the "Copy to" field, enter `B1:B10` (assuming you want to copy the filtered data to cell B1).
  - **Step 17**: Click "OK".

### Example Use Case

Suppose you have a table with sales data:

| Product | Sales |
| --- | --- |
| A      | 100  |
| B      | 0    |
| C      | 200  |
| D      | 0    |
| E      | 300  |

To delete rows where the sales are 0:

1. Select the entire table.
2. Go to the "Data" tab.
3. Click on "Filter" in the "Data Tools" group.
4. Filter the "Sales" column for 0.
5. Select all the rows that are filtered out.
6. Right-click on the selected rows and choose "Delete".

The resulting table will be:

| Product | Sales |
| --- | --- |
| A      | 100  |
| C      | 200  |
| E      | 300  |