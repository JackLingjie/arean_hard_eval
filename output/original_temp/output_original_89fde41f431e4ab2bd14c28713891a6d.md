**Retrieving Selection and Cursor Position in QTextEdit (PySide6)**

To retrieve the current selection and cursor position in a `QTextEdit` widget using PySide6, follow these steps:

### Step 1: Get the Current Selection

First, you need to get the current selection from the `QTextEdit`. This can be done using the `toPlainText()` method.

```python
# Get the current selection as plain text
selection_text = text_edit.toPlainText()
```

### Step 2: Get the Cursor Position

Next, you need to get the cursor position. This can be done using the `textCursor()` method.

```python
# Get the cursor position
cursor_position = text_edit.textCursor().position()
```

### Example Use Case

Here's a complete example:

```python
import sys
from PySide6.QtWidgets import QApplication, QTextEdit

class QTextEditExample:
    def __init__(self):
        self.app = QApplication(sys.argv)
        self.text_edit = QTextEdit()

        # Set up the UI
        self.text_edit.show()

        # Connect signals
        self.text_edit.cursorPositionChanged.connect(self.update_cursor_position)
        self.text_edit.selectionChanged.connect(self.update_selection)

    def update_cursor_position(self):
        cursor_position = self.text_edit.textCursor().position()
        print(f"Cursor Position: {cursor_position}")

    def update_selection(self):
        selection_text = self.text_edit.toPlainText()
        print(f"Selection Text: {selection_text}")

    def run(self):
        self.app.exec()

if __name__ == "__main__":
    example = QTextEditExample()
    example.run()
```

### Explanation

- **Step 1**: The `toPlainText()` method retrieves the entire text in the `QTextEdit`.
- **Step 2**: The `textCursor().position()` method gets the current cursor position.

### Advice

- Use the `cursorPositionChanged` signal to update the cursor position.
- Use the `selectionChanged` signal to update the selection text.

This example demonstrates how to retrieve the current selection and cursor position in a `QTextEdit` widget using PySide6.