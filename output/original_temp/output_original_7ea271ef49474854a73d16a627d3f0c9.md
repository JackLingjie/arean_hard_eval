**Building an Invoice App with Python**

This guide will walk you through the steps to create a basic invoice application using Python. The app will allow users to:

1. **Create** invoices
2. **View** existing invoices
3. **Edit** invoices
4. **Delete** invoices

### Step 1: **Set Up the Project**

**Create a new directory** for your project and navigate into it:

```bash
mkdir invoice_app
cd invoice_app
```

**Initialize a new Python project**:

```bash
python -m venv venv
```

**Activate the virtual environment**:

```bash
# On Windows
venv\Scripts\activate

# On macOS/Linux
source venv/bin/activate
```

### Step 2: **Install Required Libraries**

**Install the following libraries**:

```bash
pip install flask
pip install pandas
```

### Step 3: **Design the Database**

**Create a simple database** to store invoices:

```python
import pandas as pd

class InvoiceDB:
    def __init__(self):
        self.invoices = pd.DataFrame(columns=['Invoice ID', 'Customer Name', 'Invoice Date', 'Total'])

    def create_invoice(self, invoice_id, customer_name, invoice_date, total):
        new_invoice = pd.DataFrame({
            'Invoice ID': [invoice_id],
            'Customer Name': [customer_name],
            'Invoice Date': [invoice_date],
            'Total': [total]
        })
        self.invoices = pd.concat([self.invoices, new_invoice])

    def view_invoices(self):
        return self.invoices

    def edit_invoice(self, invoice_id, customer_name=None, invoice_date=None, total=None):
        if customer_name:
            self.invoices.loc[self.invoices['Invoice ID'] == invoice_id, 'Customer Name'] = customer_name
        if invoice_date:
            self.invoices.loc[self.invoices['Invoice ID'] == invoice_id, 'Invoice Date'] = invoice_date
        if total:
            self.invoices.loc[self.invoices['Invoice ID'] == invoice_id, 'Total'] = total

    def delete_invoice(self, invoice_id):
        self.invoices = self.invoices[self.invoices['Invoice ID'] != invoice_id]
```

### Step 4: **Create the Flask App**

**Create a new file** `app.py`:

```python
from flask import Flask, request, jsonify
from invoice_db import InvoiceDB

app = Flask(__name__)

invoice_db = InvoiceDB()

@app.route('/invoices', methods=['GET'])
def get_invoices():
    return jsonify(invoice_db.view_invoices().to_dict(orient='records'))

@app.route('/invoices', methods=['POST'])
def create_invoice():
    data = request.json
    invoice_db.create_invoice(data['invoice_id'], data['customer_name'], data['invoice_date'], data['total'])
    return jsonify({'message': 'Invoice created successfully'}), 201

@app.route('/invoices/<int:invoice_id>', methods=['PUT'])
def edit_invoice(invoice_id):
    data = request.json
    invoice_db.edit_invoice(invoice_id, data.get('customer_name'), data.get('invoice_date'), data.get('total'))
    return jsonify({'message': 'Invoice updated successfully'})

@app.route('/invoices/<int:invoice_id>', methods=['DELETE'])
def delete_invoice(invoice_id):
    invoice_db.delete_invoice(invoice_id)
    return jsonify({'message': 'Invoice deleted successfully'})

if __name__ == '__main__':
    app.run(debug=True)
```

### Step 5: **Run the App**

**Run the Flask app**:

```bash
python app.py
```

**Use a tool like `curl`** to interact with the API:

```bash
# Create an invoice
curl -X POST -H "Content-Type: application/json" -d '{"invoice_id": 1, "customer_name": "John Doe", "invoice_date": "2023-03-01", "total": 100.0}' http://localhost:5000/invoices

# View all invoices
curl -X GET http://localhost:5000/invoices

# Edit an invoice
curl -X PUT -H "Content-Type: application/json" -d '{"customer_name": "Jane Doe"}' http://localhost:5000/invoices/1

# Delete an invoice
curl -X DELETE http://localhost:5000/invoices/1
```

This is a basic example to get you started. You can enhance the app by adding more features, error handling, and security measures.