**Retrieving Daily Stock Data from Yahoo Finance and Plotting**

This example demonstrates how to use the `yfinance` library to fetch daily stock data and plot it using `matplotlib`.

### Prerequisites

- Install the required libraries:
  ```bash
  pip install yfinance matplotlib
  ```

### Code

```python
# Import necessary libraries
import yfinance as yf
import matplotlib.pyplot as plt

# Define the stock ticker symbol
stock_ticker = "AAPL"  # Apple Inc.

# Download the daily stock data
stock_data = yf.Ticker(stock_ticker).history(period="1y")

# Print the first few rows of the data
print(stock_data.head())

# Plot the closing price over time
plt.figure(figsize=(10, 6))
plt.plot(stock_data.index, stock_data['Close'], label=f"{stock_ticker} Closing Price")

# Add title and labels
plt.title(f"Daily Closing Price of {stock_ticker}")
plt.xlabel("Date")
plt.ylabel("Price (USD)")

# Display legend and show the plot
plt.legend()
plt.show()
```

### Explanation

1. **Import Libraries**: 
   - `yfinance` for fetching stock data.
   - `matplotlib.pyplot` for plotting.

2. **Define Stock Ticker**: 
   - Specify the stock ticker symbol you're interested in.

3. **Fetch Daily Stock Data**:
   - Use `yf.Ticker(stock_ticker).history(period="1y")` to download the daily stock data for the specified period.

4. **Print Data**:
   - Display the first few rows of the data.

5. **Plot Closing Price**:
   - Use `plt.plot` to create a line plot of the closing price over time.

6. **Customize Plot**:
   - Set the figure size.
   - Add a title and labels for the x and y axes.

7. **Display Legend and Plot**:
   - Show the legend.
   - Display the plot.

### Example Use Cases

- **Multiple Stocks**: To plot multiple stocks, simply modify the `stock_ticker` variable to include the tickers of the stocks you're interested in.
- **Custom Period**: Adjust the `period` parameter in `yf.Ticker(stock_ticker).history(period="1y")` to change the time period for which you want to fetch data.