To directly download a page using its URL in a browser's console, you can use the following methods:

### 1. Using the `fetch` API

- **Step 1**: Open the browser's developer console. You can do this by pressing `F12` or by right-clicking on the page and selecting "Inspect" or "Inspect Element."

- **Step 2**: In the console, type the following command:

  ```javascript
  fetch('https://example.com') // Replace 'https://example.com' with the URL you want to download.
    .then(response => response.blob())
    .then(blob => {
      const url = URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = 'example.pdf'; // Specify the file name you want to save it as.
      a.click();
      URL.revokeObjectURL(url);
    });
  ```

- **Step 3**: Press Enter to execute the command.

### 2. Using the `axios` Library

If you have the `axios` library available, you can use it to download the page.

- **Step 1**: Ensure you have `axios` installed. If not, you can include it in your project by adding the following script tag:

  ```html
  <script src="https://cdn.jsdelivr.net/npm/axios@0.21.1/dist/axios.min.js"></script>
  ```

- **Step 2**: Use the following command in the console:

  ```javascript
  axios.get('https://example.com', { responseType: 'blob' })
    .then(response => {
      const url = URL.createObjectURL(response.data);
      const a = document.createElement('a');
      a.href = url;
      a.download = 'example.pdf'; // Specify the file name you want to save it as.
      a.click();
      URL.revokeObjectURL(url);
    });
  ```

- **Step 3**: Press Enter to execute the command.

### 3. Using the `XMLHttpRequest` Object

- **Step 1**: Open the browser's developer console.

- **Step 2**: Use the following command:

  ```javascript
  var xhr = new XMLHttpRequest();
  xhr.open('GET', 'https://example.com', true);
  xhr.responseType = 'blob';
  xhr.onload = function() {
    if (xhr.status === 200) {
      const url = URL.createObjectURL(xhr.response);
      const a = document.createElement('a');
      a.href = url;
      a.download = 'example.pdf'; // Specify the file name you want to save it as.
      a.click();
      URL.revokeObjectURL(url);
    }
  };
  xhr.send();
  ```

- **Step 3**: Press Enter to execute the command.

Replace `'https://example.com'` with the URL of the page you want to download. The file will be saved with the specified name.