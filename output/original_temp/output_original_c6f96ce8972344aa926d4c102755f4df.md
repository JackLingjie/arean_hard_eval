**Scraping Content without Selenium**

When scraping content, consider using libraries that don't require a full-fledged browser like Selenium. Here are some alternatives:

### **1. Requests and BeautifulSoup**

- **Requests**: Send HTTP requests to retrieve web pages.
- **BeautifulSoup**: Parse HTML and XML documents.

**Example Code:**

```python
import requests
from bs4 import BeautifulSoup

# Send a GET request
url = "http://example.com"
response = requests.get(url)

# If the GET request is successful, the status code will be 200
if response.status_code == 200:
    # Get the content of the response
    page_content = response.content

    # Create a BeautifulSoup object and specify the parser
    soup = BeautifulSoup(page_content, 'html.parser')

    # Find all links on the page
    links = soup.find_all('a')

    # Print the links
    for link in links:
        print(link.get('href'))
```

### **2. Scrapy**

- **Scrapy**: A fast high-level screen scraping and web crawling framework.

**Example Code:**

```python
import scrapy

class ExampleSpider(scrapy.Spider):
    name = "example"
    start_urls = [
        'http://example.com/',
    ]

    def parse(self, response):
        # Extract links from the page
        links = response.css('a::attr(href)').get()

        # Yield a dictionary containing the link
        yield {'link': links}
```

### **3. PyQuery**

- **PyQuery**: A Python port of the jQuery library.

**Example Code:**

```python
import pyquery

# Send a GET request
url = "http://example.com"
response = requests.get(url)

# Create a PyQuery object
pq = pyquery.PyQuery(response.content)

# Find all links on the page
links = pq('a')

# Print the links
for link in links.items():
    print(link.attr('href'))
```

### **4. lxml**

- **lxml**: A Pythonic binding for the C libraries `libxml2` and `libxslt`.

**Example Code:**

```python
import lxml.html

# Send a GET request
url = "http://example.com"
response = requests.get(url)

# Parse the HTML content
doc = lxml.html.fromstring(response.content)

# Find all links on the page
links = doc.xpath('//a/@href')

# Print the links
for link in links:
    print(link)
```

Each of these libraries has its strengths and use cases. Choose the one that best fits your project's requirements.