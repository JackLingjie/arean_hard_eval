To create a chatbot that answers questions from both CSV and PDF files, we'll break down the process into several steps. This will involve:

1. **Data Preparation**:
   - **CSV Files**: Ensure the CSV files are properly formatted and contain relevant information.
   - **PDF Files**: Extract text from PDFs using Optical Character Recognition (OCR) techniques.

2. **Data Storage**:
   - Store the extracted text from CSV and PDF files in a database or a structured format.

3. **Question-Answering System**:
   - Implement a question-answering system that can query the stored data.

Here's a more detailed outline:

### Step 1: Data Preparation

- **CSV Files**:
  - Ensure the CSV files are properly formatted and contain relevant information.
  - You can use libraries like `pandas` in Python to read and manipulate CSV files.

- **PDF Files**:
  - Use Optical Character Recognition (OCR) techniques to extract text from PDFs.
  - Libraries like `PyPDF2` or `pdfplumber` can be used for this purpose.

### Step 2: Data Storage

- Store the extracted text from CSV and PDF files in a database or a structured format.
- You can use databases like SQLite or MongoDB.

### Step 3: Question-Answering System

- Implement a question-answering system that can query the stored data.
- You can use libraries like `spaCy` for natural language processing.

### Example Code

Here's a basic example using Python:

```python
import pandas as pd
from pdfplumber import pdf2txt
import sqlite3

# Connect to SQLite database
conn = sqlite3.connect('data.db')
cursor = conn.cursor()

# Create table
cursor.execute('''
    CREATE TABLE IF NOT EXISTS data (
        id INTEGER PRIMARY KEY,
        text TEXT
    )
''')

# Read CSV file
df = pd.read_csv('data.csv')

# Insert CSV data into database
for index, row in df.iterrows():
    cursor.execute("INSERT INTO data (text) VALUES (?)", (row['text'],))

# Extract text from PDF
with open('data.pdf', 'rb') as f:
    pdf_text = pdf2txt(f)

# Insert PDF text into database
cursor.execute("INSERT INTO data (text) VALUES (?)", (pdf_text,))

# Commit changes
conn.commit()

# Close connection
conn.close()

# Question-answering system
def answer_question(question):
    # Query database
    cursor.execute("SELECT text FROM data WHERE text LIKE ?", ('%' + question + '%',))
    results = cursor.fetchall()

    # Return answer
    return results

# Test the question-answering system
print(answer_question('example question'))
```

### Step 4: Deploy the Chatbot

- Deploy the chatbot on a platform like Heroku or AWS.

### Step 5: Integrate with a Chat Interface

- Integrate the chatbot with a chat interface like Dialogflow or Botpress.

### Step 6: Test the Chatbot

- Test the chatbot thoroughly.

### Step 7: Refine the Chatbot

- Refine the chatbot based on user feedback.

This is a basic outline. Depending on your specific requirements, you may need to add more steps or modify these steps.