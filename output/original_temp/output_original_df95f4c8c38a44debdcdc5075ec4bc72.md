**Extracting Tables from PDF Files using Python**

To extract tables from PDF files, you can use the `PyPDF2` library for reading PDFs and `tabula-py` for extracting tables.

### Prerequisites

- **Python**: Ensure you have Python installed on your system.
- **`PyPDF2`**: Install this library using pip: `pip install PyPDF2`.
- **`tabula-py`**: Install this library using pip: `pip install tabula-py`.

### Code

```python
import PyPDF2
import tabula

def extract_tables_from_pdf(file_path):
    """
    Extracts tables from a PDF file.

    Args:
    - file_path (str): Path to the PDF file.

    Returns:
    - A list of extracted tables.
    """
    try:
        # Read the PDF file
        with open(file_path, 'rb') as f:
            pdf_reader = PyPDF2.PdfReader(f)

        # Extract tables from each page
        tables = []
        for page in pdf_reader.pages:
            extracted_table = tabula.read_pdf(file_path, pages=page.page_number)
            tables.extend(extracted_table)

        return tables

    except FileNotFoundError:
        print(f"File {file_path} not found.")
        return []

    except Exception as e:
        print(f"An error occurred: {e}")
        return []

# Example usage
file_path = 'path_to_your_pdf_file.pdf'
tables = extract_tables_from_pdf(file_path)

# Print the extracted tables
for i, table in enumerate(tables):
    print(f"Table {i+1}:")
    print(table)
    print("\n")
```

### Explanation

1. **Import Libraries**: The code starts by importing the necessary libraries: `PyPDF2` for reading PDFs and `tabula-py` for extracting tables.

2. **Function Definition**: The `extract_tables_from_pdf` function takes the path to a PDF file as input and returns a list of extracted tables.

3. **Try-Except Block**: The function is wrapped in a try-except block to handle potential errors.

4. **Read PDF File**: Inside the try block, the PDF file is read using `PyPDF2`.

5. **Extract Tables**: For each page in the PDF, the `tabula.read_pdf` function is used to extract tables.

6. **Return Tables**: The extracted tables are returned as a list.

7. **Example Usage**: The code includes an example usage section where you can replace `'path_to_your_pdf_file.pdf'` with the path to your PDF file.

### Note

- Ensure you replace `'path_to_your_pdf_file.pdf'` with the actual path to your PDF file.
- This code assumes that the PDF file contains tables. If the PDF does not contain tables, the `tabula.read_pdf` function will return an empty list.