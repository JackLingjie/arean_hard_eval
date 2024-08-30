**Web Scraping with Beautiful Soup**

This example demonstrates how to web scrape the [Naivas Online](https://naivas.online) website using Python and Beautiful Soup.

### Prerequisites

- **Python 3.x**: Ensure you have Python installed on your system.
- **Beautiful Soup 4**: Install Beautiful Soup using pip:
  ```bash
  pip install beautifulsoup4
  ```
- **Requests Library**: Install the Requests library using pip:
  ```bash
  pip install requests
  ```

### Code

```python
# Import necessary libraries
import requests
from bs4 import BeautifulSoup

# Send a GET request to the website
def send_get_request(url):
    """Sends a GET request to the provided URL."""
    try:
        response = requests.get(url)
        response.raise_for_status()  # Raise an exception for HTTP errors
        return response.text
    except requests.RequestException as e:
        print(f"Request Exception: {e}")
        return None

# Parse the HTML content using Beautiful Soup
def parse_html(html_content):
    """Parses the HTML content using Beautiful Soup."""
    try:
        soup = BeautifulSoup(html_content, 'html.parser')
        return soup
    except Exception as e:
        print(f"Error parsing HTML: {e}")
        return None

# Extract relevant data from the parsed HTML
def extract_data(soup):
    """Extracts relevant data from the parsed HTML."""
    try:
        # Example: Extract all product names
        product_names = [item.text.strip() for item in soup.find_all('h2', class_='product-name')]
        return product_names
    except Exception as e:
        print(f"Error extracting data: {e}")
        return None

# Main function
def main():
    url = "https://naivas.online"
    html_content = send_get_request(url)
    soup = parse_html(html_content)
    data = extract_data(soup)

    if data:
        print("Product Names:")
        for product in data:
            print(product)

if __name__ == "__main__":
    main()
```

### Explanation

1. **Send a GET Request**: The `send_get_request` function sends a GET request to the provided URL and returns the HTML content.
2. **Parse HTML Content**: The `parse_html` function uses Beautiful Soup to parse the HTML content.
3. **Extract Relevant Data**: The `extract_data` function extracts relevant data from the parsed HTML. In this example, it extracts all product names.

### Example Use Case

- **Product Names**: This code extracts all product names from the Naivas Online website.

### Advice

- **Respect Website Terms**: Always check the website's terms of use before web scraping.
- **Handle Exceptions**: Implement exception handling to ensure your code remains stable.
- **Use User Agents**: Consider using user agents to mimic browser behavior.