**Extracting Meta Tokens with Python**

To extract the meta token with a property called "og:image" from a webpage's source code, you can use the following Python script:

### Required Libraries

- **`requests`**: For sending HTTP requests.
- **`BeautifulSoup`**: For parsing HTML and XML documents.

### Installation

```bash
pip install requests beautifulsoup4
```

### Code

```python
import requests
from bs4 import BeautifulSoup

def extract_meta_token(url):
    """
    Extracts the meta token with 'og:image' property from a webpage.

    Args:
        url (str): The URL of the webpage.

    Returns:
        str: The extracted meta token value.
    """

    # Send an HTTP GET request to the URL
    response = requests.get(url)

    # Check if the request was successful
    if response.status_code != 200:
        print(f"Failed to retrieve the webpage. Status code: {response.status_code}")
        return None

    # Parse the HTML content using BeautifulSoup
    soup = BeautifulSoup(response.text, 'html.parser')

    # Find the meta tag with 'og:image' property
    meta_tag = soup.find('meta', property='og:image')

    # Return the content of the meta tag if found
    if meta_tag:
        return meta_tag.get('content')
    else:
        print("Meta token with 'og:image' property not found.")
        return None

# Example usage
url = "https://example.com"
meta_token = extract_meta_token(url)

if meta_token:
    print(f"Extracted meta token: {meta_token}")
```

### Explanation

1. **Send an HTTP GET Request**: Use `requests.get()` to fetch the webpage's source code.
2. **Parse HTML Content**: Utilize `BeautifulSoup` to parse the HTML content.
3. **Find the Meta Tag**: Use `soup.find()` to locate the meta tag with the "og:image" property.
4. **Return the Meta Token**: If the meta tag is found, return its content.

### Example Use Case

Replace `"https://example.com"` with the URL of the webpage you want to extract the meta token from. The script will print the extracted meta token value.