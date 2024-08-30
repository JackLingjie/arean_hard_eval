**Petty Cash Account Tracker**

This Visual Basic program allows you to record daily transactions for your company's petty cash account. It includes a running total feature.

### **Code**

```vb
' Petty Cash Account Tracker

' Form Design:
'   - `txtDate`: Date of transaction
'   - `txtDescription`: Brief description of the transaction
'   - `txtAmount`: Amount of the transaction
'   - `lstTransactions`: List box to display recorded transactions
'   - `lblRunningTotal`: Label to display the running total

Imports System

Public Class PettyCashTracker

    ' Initialize running total
    Private runningTotal As Decimal = 0

    Private Sub btnRecordTransaction_Click(sender As Object, e As EventArgs) Handles btnRecordTransaction.Click
        ' Get transaction details
        Dim dateValue As Date = DateTime.ParseExact(txtDate.Text, "yyyy-MM-dd", Nothing)
        Dim description As String = txtDescription.Text
        Dim amount As Decimal = Decimal.Parse(txtAmount.Text)

        ' Update running total
        runningTotal += amount

        ' Display transaction in list box
        lstTransactions.Items.Add($"{dateValue.ToString("yyyy-MM-dd")}: {description} - ${amount}")

        ' Update running total label
        lblRunningTotal.Text = $"Running Total: ${runningTotal}"

        ' Clear input fields
        txtDate.Clear()
        txtDescription.Clear()
        txtAmount.Clear()
    End Sub

    Private Sub btnClearTransactions_Click(sender As Object, e As EventArgs) Handles btnClearTransactions.Click
        ' Clear list box and running total
        lstTransactions.Items.Clear()
        runningTotal = 0
        lblRunningTotal.Text = $"Running Total: ${runningTotal}"
    End Sub
End Class
```

### **Explanation**

1. **Initialization**: The `runningTotal` variable is initialized to 0.

2. **Recording Transactions**:
   - The `btnRecordTransaction_Click` event handler retrieves the transaction details from the input fields.
   - It updates the `runningTotal` by adding the transaction amount.
   - The transaction is displayed in the list box (`lstTransactions`).
   - The running total is updated in the label (`lblRunningTotal`).
   - The input fields are cleared.

3. **Clearing Transactions**:
   - The `btnClearTransactions_Click` event handler clears the list box (`lstTransactions`) and resets the `runningTotal` to 0.
   - The running total label (`lblRunningTotal`) is updated.

### **Example Use Case**

1. **Record a Transaction**:
   - Enter the date (`txtDate`), description (`txtDescription`), and amount (`txtAmount`) of the transaction.
   - Click the **Record Transaction** button (`btnRecordTransaction`).

2. **View Running Total**:
   - The running total is displayed in the label (`lblRunningTotal`).

3. **Clear Transactions**:
   - Click the **Clear Transactions** button (`btnClearTransactions`) to reset the list box and running total.

This program provides a simple and effective way to manage your company's petty cash account.