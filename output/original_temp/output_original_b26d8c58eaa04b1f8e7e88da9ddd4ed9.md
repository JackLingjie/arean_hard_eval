The Python code you've written is a good start. However, there are a few potential issues that might be causing the PDF to be corrupted or not openable:

1. **Lack of Authentication**: The Power BI URL you're accessing requires authentication. When you manually enter the URL in your browser, you're prompted to log in to your Power BI account. Your Python script doesn't include any authentication steps.

2. **Session Management**: Even if you authenticate successfully, the session might not be properly managed. This could lead to issues with downloading the PDF.

Here's an updated version of your Python script that includes authentication:

```python
import requests
from requests.auth import HTTPBasicAuth
import os

# Main Power BI report URL
full_url = "https://app.powerbi.com/groups/me/rdlreports/1bdef01c-30a3-4150-aff2-b3ec4c9edf86?rp:AdviceDeathScriptMERGEDMonthStartDate=6/1/2023&rp:AdviceDeathScriptMERGEDIncomingcall=Aria%20Park&rdl:format=PDF"

# Power BI login credentials
username = "your_power_bi_username"
password = "your_power_bi_password"

# Set up authentication
auth = HTTPBasicAuth(username, password)

# Send a GET request to Power BI
response = requests.get(full_url, auth=auth)

# Check if the request was successful
if response.status_code == 200:
    # Extract the filename from the URL
    filename = f"AriaPark.pdf"
    
    # Save the response content to a file
    with open(filename, 'wb') as file:
        file.write(response.content)
    
    print("Reports have been successfully downloaded.")
else:
    print(f"Failed to download report. Status code: {response.status_code}")
```

**Important**: Replace `"your_power_bi_username"` and `"your_power_bi_password"` with your actual Power BI login credentials.

**Additional Tips**:

- Ensure that your Power BI report URL is correct. The report ID (`1bdef01c-30a3-4150-aff2-b3ec4c9edf86`) should match the one in your Power BI report.
- If you're using a proxy server, you might need to configure your Python script to use it.
- If you're still experiencing issues, try checking the PDF file's properties to see if it's corrupted.