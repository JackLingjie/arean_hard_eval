**Archiving Files into Separate Zip Files**

This Python program archives files in a specified folder into separate zip files on Linux.

### Prerequisites

- Python 3.x installed on your system.
- The `zipfile` module is part of Python's standard library, so no additional installations are required.

### Code

```python
import os
import zipfile

def archive_files(folder_path):
    """
    Archives files in a specified folder into separate zip files.

    Args:
        folder_path (str): Path to the folder containing files to be archived.

    Returns:
        None
    """

    # Check if the specified folder exists
    if not os.path.exists(folder_path):
        print(f"The folder '{folder_path}' does not exist.")
        return

    # Iterate over each file in the specified folder
    for filename in os.listdir(folder_path):
        # Construct the full path to the file
        file_path = os.path.join(folder_path, filename)

        # Check if the current item is a file
        if os.path.isfile(file_path):
            # Create a zip file name by appending '.zip' to the file name
            zip_filename = filename + '.zip'

            # Create a zip file object
            with zipfile.ZipFile(zip_filename, 'w') as zip_file:
                # Add the file to the zip file
                zip_file.write(file_path)

            # Print a success message
            print(f"File '{filename}' archived successfully.")

# Example usage
folder_path = '/path/to/your/folder'
archive_files(folder_path)
```

### Explanation

1. **Import Required Modules**: The program starts by importing the necessary modules: `os` for interacting with the operating system and `zipfile` for handling zip files.

2. **Define the `archive_files` Function**: This function takes a `folder_path` parameter, which specifies the path to the folder containing files to be archived.

3. **Check if the Folder Exists**: Before proceeding, the program checks if the specified folder exists. If it does not, a message is printed indicating the folder's non-existence.

4. **Iterate Over Files in the Folder**: The function then iterates over each file in the specified folder.

5. **Construct Full File Paths**: For each file, the program constructs its full path by joining the folder path and the file name.

6. **Check if the Current Item is a File**: It checks if the current item is a file. If it is, the program proceeds to archive the file.

7. **Create a Zip File Name**: A zip file name is created by appending '.zip' to the file name.

8. **Create a Zip File Object**: A zip file object is created using the `zipfile.ZipFile` class.

9. **Add the File to the Zip File**: The file is added to the zip file using the `write` method.

10. **Print a Success Message**: After successfully archiving a file, a success message is printed.

### Example Usage

Replace `'/path/to/your/folder'` with the actual path to the folder containing files you want to archive.

```python
folder_path = '/path/to/your/folder'
archive_files(folder_path)
```

This program provides a simple way to archive files in a specified folder into separate zip files on Linux.