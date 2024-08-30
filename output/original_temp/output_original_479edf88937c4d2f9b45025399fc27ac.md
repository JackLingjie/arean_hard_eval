**Recursive Request Retrier Function**

The following JavaScript function, `retryRequest`, attempts to make a request up to three times before resolving the promise. It uses recursion to achieve this.

### Code

```javascript
function retryRequest(url) {
  /**
   * Makes a request to the specified URL, retrying up to 3 times if it fails.
   *
   * @param {string} url - The URL to make the request to.
   * @returns {Promise} A promise that resolves with the response.
   */

  // Define the maximum number of retries
  const maxRetries = 3;

  // Define the recursive function
  function recursiveRequest(retries) {
    // Make the request
    const xhr = new XMLHttpRequest();
    xhr.open('GET', url, true);
    xhr.onload = () => {
      // If the request is successful, resolve the promise
      if (xhr.status >= 200 && xhr.status < 300) {
        resolve(xhr.responseText);
      } else {
        // If the request fails and we haven't exceeded the max retries, retry
        if (retries < maxRetries) {
          recursiveRequest(retries + 1);
        } else {
          // If we've exceeded the max retries, reject the promise
          reject('Maximum retries exceeded');
        }
      }
    };
    xhr.onerror = () => {
      // If the request fails and we haven't exceeded the max retries, retry
      if (retries < maxRetries) {
        recursiveRequest(retries + 1);
      } else {
        // If we've exceeded the max retries, reject the promise
        reject('Maximum retries exceeded');
      }
    };
    xhr.send();
  }

  // Initialize the promise
  return new Promise((resolve, reject) => {
    // Start the recursive request
    recursiveRequest(0);
  });
}
```

### Example Usage

```javascript
retryRequest('https://example.com')
  .then(response => console.log(response))
  .catch(error => console.error(error));
```

This function uses the `XMLHttpRequest` object to make the request. It defines a recursive function `recursiveRequest` that attempts the request up to `maxRetries` times. If the request is successful, it resolves the promise with the response text. If the request fails and we haven't exceeded the maximum retries, it retries. If we've exceeded the maximum retries, it rejects the promise.