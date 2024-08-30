**Extracting Website Links with Python**

To extract all links from a website, you can use the `requests` library to fetch the HTML content and the `BeautifulSoup` library to parse it.

### Prerequisites

- **Python 3.x**: Ensure you have Python installed on your system.
- **`requests`**: Install the `requests` library using pip: `pip install requests`.
- **`beautifulsoup4`**: Install `beautifulsoup4` using pip: `pip install beautifulsoup4`.

### Code

```python
import requests
from bs4 import BeautifulSoup

def get_website_links(url):
    """
    Retrieves all links from a given website.

    Args:
    - url (str): The URL of the website.

    Returns:
    - list: A list of all links found on the website.
    """

    try:
        # Send an HTTP GET request to the website
        response = requests.get(url)

        # Check if the request was successful
        if response.status_code == 200:
            # Parse the HTML content using BeautifulSoup
            soup = BeautifulSoup(response.text, 'html.parser')

            # Find all links on the webpage
            links = [a.get('href') for a in soup.find_all('a', href=True)]

            # Return the list of links
            return links

        else:
            print(f"Failed to retrieve the webpage. Status code: {response.status_code}")
            return []

    except Exception as e:
        print(f"An error occurred: {e}")
        return []

# Example usage
url = "https://www.example.com"
links = get_website_links(url)
print(links)
```

### Explanation

- **`requests.get(url)`**: Sends an HTTP GET request to the specified URL.
- **`BeautifulSoup(response.text, 'html.parser')`**: Parses the HTML content of the webpage.
- **`soup.find_all('a', href=True)`**: Finds all HTML anchor tags (`<a>`) with an `href` attribute.
- **`[a.get('href') for a in soup.find_all('a', href=True)]`**: Extracts the `href` values from the anchor tags.

### Notes

- This function returns a list of all links found on the website.
- It handles exceptions for failed requests and parsing errors.
- Ensure you replace `"https://www.example.com"` with the URL of the website you want to scrape.