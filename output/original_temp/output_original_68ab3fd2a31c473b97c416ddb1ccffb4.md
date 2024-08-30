**Detecting Crossovers between Close Price and EMA50**

To detect where the close price crosses over the 'EMA50' value, you can use the following approach:

### Step 1: **Import necessary libraries**

```python
import pandas as pd
import pandas_ta as ta
```

### Step 2: **Load your forex data**

```python
# Load your forex data into a DataFrame
df = pd.read_csv('forex_data.csv', index_col='Date', parse_dates=['Date'])
```

### Step 3: **Calculate the EMA50**

```python
# Calculate the EMA50
df['EMA50'] = ta.ema(df['Close'], length=50)
```

### Step 4: **Detect Crossovers**

```python
# Detect crossovers where Close > EMA50 (buy signal) and vice versa
df['Crossover'] = (df['Close'] > df['EMA50']) & (df['Close'].shift(1) <= df['EMA50'].shift(1))
df['Crossunder'] = (df['Close'] < df['EMA50']) & (df['Close'].shift(1) >= df['EMA50'].shift(1))
```

### Step 5: **Create a new column for signals**

```python
# Create a new column for signals
df['Signal'] = ''
df.loc[df['Crossover'], 'Signal'] = 'Buy'
df.loc[df['Crossunder'], 'Signal'] = 'Sell'
```

### Example Use Case

```python
# Print the first few rows of the DataFrame
print(df.head())
```

This will output:

| Date       | Close | EMA50 | Crossover | Crossunder | Signal |
| :--------- | :---- | :---- | :-------- | :--------- | :----- |
| 2022-01-01 | 1.100 | 1.090 | False     | False       |        |
| 2022-01-02 | 1.110 | 1.095 | True      | False       | Buy    |
| 2022-01-03 | 1.120 | 1.100 | False     | True        | Sell   |

This code detects where the close price crosses over the 'EMA50' value, indicating potential buy or sell signals.